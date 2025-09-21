// Path: lib/features/categories/data/datasources/categoriesdetails_remote_data_source.dart
import 'package:mohalla_bazaar/core/network/api_client.dart';
import 'package:mohalla_bazaar/modules/categorydetails/data/model/categorydetails_response.dart';

abstract class CategoriesDetailsRemoteDataSource {
  Future<CategoryDetailsResponse> fetchCategoryDetails(String categoryId);
}

class CategoriesDetailsRemoteDataSourceImpl implements CategoriesDetailsRemoteDataSource {
  final ApiClient apiClient;

  CategoriesDetailsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<CategoryDetailsResponse> fetchCategoryDetails(String categoryId) async {
    final response = await apiClient.getProducts(categoryId);
    return response;
  }
}
