import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<List<NotificationEntity>> getCached() async {
    return repository.getCachedNotifications();
  }

  Future<List<NotificationEntity>> fetchFromApi(String userId) async {
    return repository.fetchNotifications(userId);
  }
}
