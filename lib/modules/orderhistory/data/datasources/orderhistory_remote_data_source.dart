// Remote data source - API call ke liye
import 'package:mohalla_bazaar/core/network/api_client.dart';
import '../models/orderhistory_response.dart';

abstract class OrderHistoryRemoteDataSource {
  Future<OrderHistoryResponse> fetchOrderHistory(String userId);
}

class OrderHistoryRemoteDataSourceImpl implements OrderHistoryRemoteDataSource {
  final ApiClient apiClient;

  OrderHistoryRemoteDataSourceImpl(this.apiClient);

  @override
  Future<OrderHistoryResponse> fetchOrderHistory(String userId) async {
    try {
      final response = await apiClient.getOrderHistory(userId);

      return response;
    } catch (e) {
      print("❌ Failed to fetch OrderHistory from API: $e");
      rethrow; // upar tak propagate karna zaruri hai, taki repository decide kare
    }
  }
}
