import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/core/constants/app_strings.dart';

class OrderApi {
  final Dio dio;

  OrderApi({Dio? dioClient}) : dio = dioClient ?? Dio();

  /// 🔹 Track Order by orderId
  Future<Map<String, dynamic>?> trackOrder(String orderId) async {
    try {
      final response = await dio.get(
        "${AppStrings.baseurl}trackOrderById/$orderId",
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return response.data['data']; // order details map me milenge
      } else {
        return null;
      }
    } catch (e) {
     
      return null;
    }
  }
}
