// Path: lib/features/categories/data/datasources/parent_categorydetails_local_data_source.dart
// Path: lib/features/parent_categorydetails/data/datasources/parent_categorydetails_local_data_source.dart
import 'dart:convert';
import 'package:mohalla_bazaar/core/network/isar_client.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/data/model/parent_categorydetails_cache_model.dart';

abstract class ParentCategoryDetailsLocalDataSource {
  Future<List<ParentCategoryDetailsCacheModel>> getCachedDetails();
  Future<void> saveDetails(List<ParentCategoryDetailsCacheModel> list);
}

class ParentCategoryDetailsLocalDataSourceImpl implements ParentCategoryDetailsLocalDataSource {
  @override
  Future<List<ParentCategoryDetailsCacheModel>> getCachedDetails() {
    return IsarClient.getParentCategoryDetails();
  }

  @override
  Future<void> saveDetails(List<ParentCategoryDetailsCacheModel> list) {
    return IsarClient.saveParentCategoryDetails(list);
  }
}
