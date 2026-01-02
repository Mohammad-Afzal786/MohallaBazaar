// Path: lib/features/parent_category_details/data/datasources/parent_categorydetails_local_data_source.dart

import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/data/model/parent_categorydetails_cache_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ParentCategoryDetailsLocalDataSource {
  Future<List<ParentCategoryDetailsCacheModel>> getCachedDetails(String parentCategoryId);
  Future<void> saveDetails(List<ParentCategoryDetailsCacheModel> list, String parentCategoryId);
}

class ParentCategoryDetailsLocalDataSourceImpl
    implements ParentCategoryDetailsLocalDataSource {

  @override
  Future<List<ParentCategoryDetailsCacheModel>> getCachedDetails(String categoryId) async {
    final db = SQLiteClient.instance;
    final maps = await db.query(
      'parent_category_details',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    return maps.map((m) => ParentCategoryDetailsCacheModel.fromMap(m)).toList();
  }

  @override
  Future<void> saveDetails(List<ParentCategoryDetailsCacheModel> list, String categoryId) async {
    final db = SQLiteClient.instance;
    await db.transaction((txn) async {
      // Delete only this category's old data
      await txn.delete(
        'parent_category_details',
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );

      // Insert new data
      for (var item in list) {
        await txn.insert(
          'parent_category_details',
          item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }
}
