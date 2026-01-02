import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getCachedNotifications();
  Future<List<NotificationEntity>> fetchNotifications(String userId);
}
