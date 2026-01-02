// Path: lib/features/viewcart/data/datasources/viewcart_remote_data_source.dart
import 'package:mohalla_bazaar/core/network/api_client.dart';
import '../models/viewcart_response.dart';

abstract class ViewCartRemoteDataSource {
  Future<ViewCartResponse> fetchViewCart(String userId);
}

class ViewCartRemoteDataSourceImpl implements ViewCartRemoteDataSource {
  final ApiClient apiClient;

  ViewCartRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ViewCartResponse> fetchViewCart(String userId) async {
    final response = await apiClient.getViewCart(userId);
    return response;
  }
}
