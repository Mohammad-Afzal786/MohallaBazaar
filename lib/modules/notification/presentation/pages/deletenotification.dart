import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/core/constants/app_strings.dart';

Future<void> deleteNotification({
  required String userId,
  required String notificationId,
  // optional bearer token
}) async {
  try {
    final dio = Dio();
    final response = await dio.delete(
      "${AppStrings.baseurl}deleteNotificationById",    
      queryParameters: {
        'userId': userId,
        'notificationId': notificationId,
      },
      
    );
    if (response.statusCode == 200) {
     
    } 
  // ignore: empty_catches
  } catch (e) {
    
  }
}
