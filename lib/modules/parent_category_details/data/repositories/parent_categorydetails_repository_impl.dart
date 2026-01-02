// Path: lib/features/parent_categorydetails/data/repositories/parent_categorydetails_repository_impl.dart
import 'dart:convert';
import 'package:mohalla_bazaar/modules/parent_category_details/data/datasources/parent_categorydetails_local_data_source.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/data/datasources/parent_categorydetails_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/data/model/parent_categorydetails_cache_model.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/data/model/parent_categorydetails_response.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/entities/parent_categorydetails_entity.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/entities/product_entity.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/repositories/parent_categorydetails_repository.dart';

class ParentCategoryDetailsRepositoryImpl implements ParentCategoryDetailsRepository {
  final ParentCategoryDetailsRemoteDataSource remote;
  final ParentCategoryDetailsLocalDataSource local;

  ParentCategoryDetailsRepositoryImpl({required this.remote, required this.local});

  /// 🔹 Pehle local cache check karo
  @override
  Future<ParentCategoryDetailsEntity?> getCachedParentCategoryDetails(String parentCategoryId) async {
    final cachedList = await local.getCachedDetails(parentCategoryId); // category-specific
    final match = cachedList.isNotEmpty ? cachedList.first : null;

    if (match != null && match.jsonData.isNotEmpty) {
      final Map<String, dynamic> json = jsonDecode(match.jsonData);
      final resp = ParentCategoryDetailsResponse.fromJson(json);

      // Fire & forget background fetch to update cache
      _fetchAndUpdateFromApi(parentCategoryId);

      return _mapResponseToEntity(resp);
    }

    // Agar cache empty ho → remote fetch
    return fetchParentCategoryDetailsFromApi(parentCategoryId);
  }

  /// 🔹 Remote fetch aur cache update
  @override
  Future<ParentCategoryDetailsEntity> fetchParentCategoryDetailsFromApi(String parentCategoryId) async {
    final resp = await remote.fetchParentCategoryDetails(parentCategoryId);

    final cache = ParentCategoryDetailsCacheModel(
      parentCategoryId: resp.data.parentCategoryId,
      jsonData: jsonEncode(resp.toJson()),
      lastUpdated: DateTime.now(),
    );

    // Category-specific save
    await local.saveDetails([cache], parentCategoryId);

    return _mapResponseToEntity(resp);
  }

  /// 🔹 Background fetch + cache update
  Future<void> _fetchAndUpdateFromApi(String parentCategoryId) async {
    try {
      final resp = await remote.fetchParentCategoryDetails(parentCategoryId);
      final cache = ParentCategoryDetailsCacheModel(
        parentCategoryId: resp.data.parentCategoryId,
        jsonData: jsonEncode(resp.toJson()),
        lastUpdated: DateTime.now(),
      );

      // Category-specific save
      await local.saveDetails([cache], parentCategoryId);
    } catch (e) {
      print("Remote fetch failed: $e");
    }
  }

  /// 🔹 Helper: map API response → Entity
  ParentCategoryDetailsEntity _mapResponseToEntity(ParentCategoryDetailsResponse resp) {
    return ParentCategoryDetailsEntity(
      parentCategoryId: resp.data.parentCategoryId,
      parentCategoryName: resp.data.parentCategoryName,
      parentCategoryImage: resp.data.parentCategoryImage,
      parentCategorySubtitle: resp.data.parentCategorySubtitle,
      categories: resp.data.categories
          .map((c) => ParentCategoryCategoryEntity(
                categoryId: c.categoryId,
                categoryName: c.categoryName,
                categoryImage: c.categoryImage,
                categorySubtitle: c.categorySubtitle,
                products: c.products
                    .map((p) => ProductEntity(
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

                        ))
                    .toList(),
              ))
          .toList(),
    );
  }
}
