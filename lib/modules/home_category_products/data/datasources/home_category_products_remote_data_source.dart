import '../models/home_category_products_response.dart';
import '../../../../core/network/api_client.dart';

abstract class HomeCategoryProductsRemoteDataSource {
  Future<HomeCategoryProductsResponse> fetchHomeCategoryProducts();
}

class HomeCategoryProductsRemoteDataSourceImpl
    implements HomeCategoryProductsRemoteDataSource {
  final ApiClient apiClient;

  HomeCategoryProductsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<HomeCategoryProductsResponse> fetchHomeCategoryProducts() async {
    final response = await apiClient.getHomeCategoryProducts();
    return response;
  }
}
