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

  /// 🔹 Pehle cache return karo
  @override
  Future<List<ProductEntity>> getProducts(String categoryId) async {
    final cachedList = await local.getCachedProducts();

    final match = cachedList.firstWhere(
      (c) => c.categoryId == categoryId,
      orElse: () => CategoryDetailsCacheModel(),
    );

    if (match.id != 0 && match.jsonData.isNotEmpty) {
      final Map<String, dynamic> json = jsonDecode(match.jsonData);
      final resp = CategoryDetailsResponse.fromJson(json);

      // Return cached first
      _fetchAndUpdateFromApi(categoryId); // fire & forget remote fetch
      return resp.productData.map(_mapRemoteToEntity).toList();
    } else {
      // Agar cache empty → remote se fetch karo
      return fetchProductsFromApi(categoryId);
    }
  }

  /// 🔹 API fetch aur cache update
  @override
  Future<List<ProductEntity>> fetchProductsFromApi(String categoryId) async {
    final resp = await remote.fetchCategoryProducts(categoryId);

    final cache = CategoryDetailsCacheModel()
      ..categoryId = categoryId
      ..jsonData = jsonEncode(resp.toJson())
      ..lastUpdated = DateTime.now();

    await local.saveProducts([cache]);

    return resp.productData.map(_mapRemoteToEntity).toList();
  }

  /// 🔹 Helper: background fetch + cache update
  Future<void> _fetchAndUpdateFromApi(String categoryId) async {
    try {
      final resp = await remote.fetchCategoryProducts(categoryId);

      final cache = CategoryDetailsCacheModel()
        ..categoryId = categoryId
        ..jsonData = jsonEncode(resp.toJson())
        ..lastUpdated = DateTime.now();

      await local.saveProducts([cache]);
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
        );
      }).toList(),
    );

    final cache = CategoryDetailsCacheModel()
      ..categoryId = categoryId
      ..jsonData = jsonEncode(resp.toJson())
      ..lastUpdated = DateTime.now();

    await local.saveProducts([cache]);
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
    );
  }
}
