// Path: lib/features/categories/data/datasources/categoriesdetails_local_data_source.dart
import 'dart:convert';

import 'package:mohalla_bazaar/core/network/isar_client.dart';

import 'package:mohalla_bazaar/modules/categorydetails/data/model/categorydetails_response.dart';

abstract class CategoriesDetailsLocalDataSource {
  Future<CategoryDetailsResponse?> getCachedCategoryDetails(String categoryId);
  Future<void> saveCategoryDetails(String categoryId, CategoryDetailsResponse response);
}

class CategoriesDetailsLocalDataSourceImpl implements CategoriesDetailsLocalDataSource {
  @override
  Future<CategoryDetailsResponse?> getCachedCategoryDetails(String categoryId) async {
    final jsonString = await IsarClient.getCategoryDetailsJson(categoryId);
    if (jsonString == null) return null;
    final Map<String, dynamic> map = json.decode(jsonString) as Map<String, dynamic>;
    return CategoryDetailsResponse.fromJson(map);
  }

  @override
  Future<void> saveCategoryDetails(String categoryId, CategoryDetailsResponse response) async {
    final jsonString = json.encode(response.toJson());
    await IsarClient.saveCategoryDetails(categoryId, jsonString);
    await IsarClient.debugPrintCaches();
  }
}
