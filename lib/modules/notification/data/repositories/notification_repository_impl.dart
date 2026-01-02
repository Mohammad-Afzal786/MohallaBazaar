import 'package:mohalla_bazaar/modules/notification/data/datasources/notification_local_data_source.dart.dart';
import 'package:mohalla_bazaar/modules/notification/data/datasources/notification_remote_data_source.dart.dart';

import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';

import '../models/notification_cache_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remote;
  final NotificationLocalDataSource local;

  NotificationRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<NotificationEntity>> getCachedNotifications() async {
    final cache = await local.getNotifications();
    return cache
        .map((c) => NotificationEntity(
              id: c.id,
              title: c.title,
              message: c.message,
              image: c.image,
              read: c.read,
              createdAt: c.createdAt,
            ))
        .toList();
  }

  @override
  Future<List<NotificationEntity>> fetchNotifications(String userId) async {
    final response = await remote.fetchNotifications(userId);

    final cacheList = response.notifications
        .map((n) => NotificationCacheModel(
              id: n.id,
              title: n.title,
              message: n.message,
              image: n.image,
              read: n.read,
              createdAt: n.createdAt,
            ))
        .toList();

    await local.saveNotifications(cacheList);

    return cacheList
        .map((c) => NotificationEntity(
              id: c.id,
              title: c.title,
              message: c.message,
              image: c.image,
              read: c.read,
              createdAt: c.createdAt,
            ))
        .toList();
  }
}
