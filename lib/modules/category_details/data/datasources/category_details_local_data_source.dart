// Path: lib/features/category_details/data/datasources/category_details_local_data_source.dart

import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import 'package:sqflite/sqflite.dart';
import '../models/category_details_cache_model.dart';

abstract class CategoryDetailsLocalDataSource {
  Future<List<CategoryDetailsCacheModel>> getCachedDetails(String categoryId);
  Future<void> saveDetails(List<CategoryDetailsCacheModel> list, String categoryId);
}

class CategoryDetailsLocalDataSourceImpl
    implements CategoryDetailsLocalDataSource {

  @override
  Future<List<CategoryDetailsCacheModel>> getCachedDetails(String categoryId) async {
    final db = SQLiteClient.instance;
    final maps = await db.query(
      'category_details',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    return maps.map((m) => CategoryDetailsCacheModel.fromMap(m)).toList();
  }

  @override
  Future<void> saveDetails(List<CategoryDetailsCacheModel> list, String categoryId) async {
    final db = SQLiteClient.instance;
    await db.transaction((txn) async {
      // Delete old cache for this category only
      await txn.delete(
        'category_details',
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );

      // Insert fresh cache
      for (var item in list) {
        final map = item.toMap();
        await txn.insert(
          'category_details',
          map,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }
}
