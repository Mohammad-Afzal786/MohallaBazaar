import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/core/constants/app_strings.dart';

class UserActivityApi {
  final Dio dio;

  UserActivityApi({Dio? dioClient}) : dio = dioClient ?? Dio();

  /// 🔹 Log user dashboard visit
  Future<bool> logDashboardVisit({required String userId}) async {
    try {
      final response = await dio.post(
        "${AppStrings.baseurl}useractivity",
        data: {"userId": userId},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error logging dashboard visit: $e");
      return false;
    }
  }

  
  
}
