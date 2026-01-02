import 'dart:convert';
import '../../domain/entities/category_details_entity.dart';
import '../../domain/repositories/category_details_repository.dart';
import '../datasources/category_details_local_data_source.dart';
import '../datasources/category_details_remote_data_source.dart';
import '../models/category_details_cache_model.dart';
import '../models/category_details_model.dart';
import '../models/category_details_response.dart';

class CategoryDetailsRepositoryImpl implements CategoryDetailsRepository {
  final CategoryDetailsRemoteDataSource remote;
  final CategoryDetailsLocalDataSource local;

  CategoryDetailsRepositoryImpl({required this.remote, required this.local});

  /// 🔹 Pehle cache check karo
  @override
  Future<List<ProductEntity>> getProducts(String categoryId) async {
    final cachedList = await local.getCachedDetails(categoryId); // per-category cache

    if (cachedList.isNotEmpty && cachedList.first.jsonData.isNotEmpty) {
      final Map<String, dynamic> json = jsonDecode(cachedList.first.jsonData);
      final resp = CategoryDetailsResponse.fromJson(json);

      // Fire & forget background fetch to update cache
      _fetchAndUpdateFromApi(categoryId);

      return resp.productData.map(_mapRemoteToEntity).toList();
    } else {
      // Agar cache empty → remote fetch
      return fetchProductsFromApi(categoryId);
    }
  }

  /// 🔹 Remote fetch aur cache update
  @override
  Future<List<ProductEntity>> fetchProductsFromApi(String categoryId) async {
    final resp = await remote.fetchCategoryProducts(categoryId);

    final cache = CategoryDetailsCacheModel(
      categoryId: categoryId,
      jsonData: jsonEncode(resp.toJson()),
      lastUpdated: DateTime.now(),
    );

    // Per-category save
    await local.saveDetails([cache], categoryId);

    return resp.productData.map(_mapRemoteToEntity).toList();
  }

  /// 🔹 Background fetch + cache update
  Future<void> _fetchAndUpdateFromApi(String categoryId) async {
    try {
      final resp = await remote.fetchCategoryProducts(categoryId);

      final cache = CategoryDetailsCacheModel(
        categoryId: categoryId,
        jsonData: jsonEncode(resp.toJson()),
        lastUpdated: DateTime.now(),
      );

      await local.saveDetails([cache], categoryId);
    } catch (e) {
      print("Remote fetch failed: $e");
    }
  }

  /// 🔹 Manual cache update
  @override
  Future<void> saveProductsToCache(
      String categoryId, List<ProductEntity> products) async {
    final resp = CategoryDetailsResponse(
      status: "success",
      success: true,
      message: "Cached Products",
      productData: products.map((p) {
        return ProductModel(
          productId: p.productId,
          productName: p.productName,
          productimage: p.productimage,
          productquantity: p.productquantity,
          productprice: p.productprice,
          productdiscountPrice: p.productdiscountPrice,
          productsaveAmount: p.productsaveAmount,
          productrating: p.productrating,
          productratag: p.productratag,
          productDescription: p.productDescription,
          productreviews: p.productreviews,
          producttime: p.producttime,
            productsimagedetails: p.productsimagedetails,
        );
      }).toList(),
    );

    final cache = CategoryDetailsCacheModel(
      categoryId: categoryId,
      jsonData: jsonEncode(resp.toJson()),
      lastUpdated: DateTime.now(),
    );

    await local.saveDetails([cache], categoryId); // per-category save
  }

  /// 🔹 Remote → Entity mapping
  ProductEntity _mapRemoteToEntity(dynamic p) {
    return ProductEntity(
      productId: p.productId,
      productName: p.productName,
      productimage: p.productimage,
      productquantity: p.productquantity,
      productprice: p.productprice,
      productdiscountPrice: p.productdiscountPrice,
      productsaveAmount: p.productsaveAmount,
      productrating: p.productrating,
      productratag: p.productratag,
      productDescription: p.productDescription,
      productreviews: p.productreviews,
      producttime: p.producttime,
      productsimagedetails: p.productsimagedetails,

    );
  }
}
