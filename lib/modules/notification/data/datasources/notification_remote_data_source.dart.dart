// Remote Data Source
import 'package:mohalla_bazaar/modules/notification/data/models/notification_response.dart';


import '../../../../core/network/api_client.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationResponse> fetchNotifications(String userId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiClient apiClient;

  NotificationRemoteDataSourceImpl(this.apiClient);

  @override
  Future<NotificationResponse> fetchNotifications(String userId) async {
    // apiClient.getNotifications() already returns NotificationResponse
    return await apiClient.getNotifications(userId);
  }
}
