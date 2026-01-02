import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import 'package:mohalla_bazaar/modules/notification/data/models/notification_cache_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class NotificationLocalDataSource {
  Future<List<NotificationCacheModel>> getNotifications();
  Future<void> saveNotifications(List<NotificationCacheModel> notifications);
  Future<void> markAsRead(String id);
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  final SQLiteClient dbClient;

  NotificationLocalDataSourceImpl(this.dbClient);

  @override
  Future<List<NotificationCacheModel>> getNotifications() async {
    try {
      final db = SQLiteClient.instance;
      final maps = await db.query(
        'notifications',
        orderBy: 'createdAt DESC',
      );

      return maps.map((e) => NotificationCacheModel.fromMap(e)).toList();
    } catch (e) {
      print('❌ SQLite getNotifications error: $e');
      return [];
    }
  }

 @override
Future<void> saveNotifications(List<NotificationCacheModel> notifications) async {
  try {
    final db = SQLiteClient.instance;

    if (notifications.isEmpty) {
      // Data empty → cache delete
      final deleted = await db.delete('notifications');
      print('✅ Notifications cache cleared. Rows deleted: $deleted');
    } else {
      // Data available → transaction में save
      await db.transaction((txn) async {
        await txn.delete('notifications'); // पुराने remove
        for (final n in notifications) {
          await txn.insert(
            'notifications',
            n.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      print('✅ Notifications saved in cache');
    }
  } catch (e) {
    print('❌ SQLite saveNotifications error: $e');
  }
}



  @override
  Future<void> markAsRead(String id) async {
    try {
      final db = SQLiteClient.instance;
      await db.update(
        'notifications',
        {'read': 1},
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('❌ SQLite markAsRead error: $e');
    }
  }
}
