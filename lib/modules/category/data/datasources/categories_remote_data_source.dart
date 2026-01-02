// Path: lib/features/categories/data/datasources/categories_remote_data_source.dart

import 'package:mohalla_bazaar/modules/category/data/model/category_response.dart';

import '../../../../core/network/api_client.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoryResponse> fetchCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final ApiClient apiClient;

  CategoriesRemoteDataSourceImpl(this.apiClient);

  @override
  Future<CategoryResponse> fetchCategories() async {
    final response = await apiClient.getCategories(); // retrofit function add करें ApiClient में
    return response;
  }
}

