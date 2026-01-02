import 'package:mohalla_bazaar/core/network/api_client.dart';
import '../models/category_details_response.dart';

abstract class CategoryDetailsRemoteDataSource {
  Future<CategoryDetailsResponse> fetchCategoryProducts(String categoryId);
}

class CategoryDetailsRemoteDataSourceImpl implements CategoryDetailsRemoteDataSource {
  final ApiClient apiClient;

  CategoryDetailsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<CategoryDetailsResponse> fetchCategoryProducts(String categoryId) async {
    final response = await apiClient.getCategoryDetails(categoryId); 
    return response;
  }
}

