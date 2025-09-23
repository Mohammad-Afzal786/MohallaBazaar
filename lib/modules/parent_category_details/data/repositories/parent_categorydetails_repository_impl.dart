// Path: lib/features/categories/data/repositories/parent_categorydetails_repository_impl.dart

// Path: lib/features/parent_categorydetails/data/repositories/parent_categorydetails_repository_impl.dart
//Explanation (हिंदी): Repository — local + remote combine करता है। Local से मिलता तो सामने दिखा देगा; remote success पर local update करेगा और fresh data return करेगा।
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

  @override
  Future<ParentCategoryDetailsEntity?> getCachedParentCategoryDetails(String parentCategoryId) async {
    final cached = await local.getCachedDetails();
    final match = cached.firstWhere(
      (c) => c.parentCategoryId == parentCategoryId,
      orElse: () => ParentCategoryDetailsCacheModel(),
    );
    if (match.id != 0 && match.jsonData.isNotEmpty) {
      final Map<String, dynamic> json = jsonDecode(match.jsonData);
      final resp = ParentCategoryDetailsResponse.fromJson(json);
      return _mapResponseToEntity(resp);
    }
    return null;
  }

  @override
  Future<ParentCategoryDetailsEntity> fetchParentCategoryDetailsFromApi(String parentCategoryId) async {
    final resp = await remote.fetchParentCategoryDetails(parentCategoryId);

    // Save as one cache entity
    final cache = ParentCategoryDetailsCacheModel()
      ..parentCategoryId = resp.data.parentCategoryId
      ..jsonData = jsonEncode(resp.toJson())
      ..lastUpdated = DateTime.now();

    await local.saveDetails([cache]);

    return _mapResponseToEntity(resp);
  }

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
                        ))
                    .toList(),
              ))
          .toList(),
    );
  }
}
