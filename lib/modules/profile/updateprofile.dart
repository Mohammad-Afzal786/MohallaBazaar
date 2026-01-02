import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/core/constants/app_strings.dart';

class UserApi {
  final Dio dio;

  UserApi({Dio? dioClient}) : dio = dioClient ?? Dio();

  Future<bool> updateUserProfile({
    required String userId,
    required String name,

  }) async {
    try {
      final response = await dio.put(
        "${AppStrings.baseurl}userProfileUpdate/$userId",
        data: {"name":name},
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
