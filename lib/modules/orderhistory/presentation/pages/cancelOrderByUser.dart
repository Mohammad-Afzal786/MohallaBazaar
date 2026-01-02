import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/core/constants/app_strings.dart';

class OrderCancelApi {
  final Dio dio;

  OrderCancelApi({Dio? dioClient}) : dio = dioClient ?? Dio();


  /// 🔹 Cancel Order by user
  Future<Map<String, dynamic>?> cancelOrderByUser(String orderId) async {
    try {
      final response = await dio.post(
        "${AppStrings.baseurl}ordercacelbyuser/$orderId",
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return response.data['data']; // cancelled order details
      } else {
        print("Cancel order failed: ${response.data['message']}");
        return null;
      }
    } catch (e) {
      print("Error in cancelOrderByUser: $e");
      return null;
    }
  }
}
