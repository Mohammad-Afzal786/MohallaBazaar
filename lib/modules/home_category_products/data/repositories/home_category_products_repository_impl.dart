import '../../domain/repositories/home_category_products_repository.dart';
import '../../domain/entities/home_category_products_entity.dart';
import '../datasources/home_category_products_remote_data_source.dart';
import '../datasources/home_category_products_local_data_source.dart';
import '../models/home_category_products_model.dart';
import 'dart:convert';

class HomeCategoryProductsRepositoryImpl
    implements HomeCategoryProductsRepository {
  final HomeCategoryProductsRemoteDataSource remote;
  final HomeCategoryProductsLocalDataSource local;

  HomeCategoryProductsRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<HomeCategoryProductsEntity>> getCachedHomeCategoryProducts() async {
    final json = await local.getCachedHomeCategoryProducts();
    if (json != null) {
      final list = jsonDecode(json) as List;
      return list
          .map((e) => HomeCategoryProductsEntity.fromModel(HomeCategoryProductsModel.fromJson(e)))
          .toList();
    }
    return [];
  }

  @override
  Future<List<HomeCategoryProductsEntity>> fetchHomeCategoryProducts() async {
    final response = await remote.fetchHomeCategoryProducts();

    // Cache save
    final json = jsonEncode(response.data.map((e) => e.toJson()).toList());
    await local.cacheHomeCategoryProducts(json);

    return response.data
        .map((e) => HomeCategoryProductsEntity.fromModel(e))
        .toList();
  }
}
