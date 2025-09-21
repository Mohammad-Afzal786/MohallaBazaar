// Path: lib/features/categories/data/repositories/categorydetails_repository_impl.dart

import 'package:mohalla_bazaar/modules/categorydetails/data/datasources/categoriesdetails_local_data_source.dart';
import 'package:mohalla_bazaar/modules/categorydetails/data/datasources/categoriesdetails_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/categorydetails/data/model/categorydetails_model.dart';
import 'package:mohalla_bazaar/modules/categorydetails/domain/entities/categorydetails_entity.dart';
import 'package:mohalla_bazaar/modules/categorydetails/domain/repositories/categorydetails_repository.dart';

class CategoryDetailsRepositoryImpl implements CategoryDetailsRepository {
  final CategoriesDetailsRemoteDataSource remote;
  final CategoriesDetailsLocalDataSource local;

  CategoryDetailsRepositoryImpl({required this.remote, required this.local});

  @override
  Future<CategoryDetailsEntity?> getCachedCategoryDetails(String categoryId) async {
    final cached = await local.getCachedCategoryDetails(categoryId);
    if (cached == null || cached.data.isEmpty) return null;
    // pick the first matching data element for this category
    final first = cached.data.firstWhere((d) => d.categoryId == categoryId, orElse: () => cached.data.first);
    return first.toEntity();
  }

  @override
  Future<CategoryDetailsEntity> fetchCategoryDetailsFromApi(String categoryId) async {
    final response = await remote.fetchCategoryDetails(categoryId);
    // save raw response JSON to local cache
    await local.saveCategoryDetails(categoryId, response);
    // convert to entity (use first item)
    final dataItem = response.data.firstWhere((d) => d.categoryId == categoryId, orElse: () => response.data.first);
    return dataItem.toEntity();
  }
}
