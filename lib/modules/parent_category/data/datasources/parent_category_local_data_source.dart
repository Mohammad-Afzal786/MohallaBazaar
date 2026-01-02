import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import 'package:sqflite/sqflite.dart';
import '../models/parent_category_model.dart';

/// Interface defining local data operations for parent categories
abstract class ParentCategoryLocalDataSource {
  Future<List<ParentCategoryModel>> getCachedCategories();
  Future<void> saveCategories(List<ParentCategoryModel> list);
}

/// Concrete implementation using SQLite
class ParentCategoryLocalDataSourceImpl implements ParentCategoryLocalDataSource {
  final db = SQLiteClient.instance;

  /// Fetch cached parent categories from SQLite
  @override
  Future<List<ParentCategoryModel>> getCachedCategories() async {
    try {
      final List<Map<String, dynamic>> maps = await db.query('parent_categories');

      if (maps.isEmpty) {
        print("ℹ️ No cached parent categories found.");
        return [];
      }

      final categories = maps.map((m) => ParentCategoryModel.fromDb(m)).toList();
      print("✅ Loaded ${categories.length} parent categories from cache.");
      return categories;
    } catch (e) {
      print("❌ Failed to get cached parent categories: $e");
      return [];
    }
  }

  /// Save parent categories to SQLite (replaces old data)
  @override
  Future<void> saveCategories(List<ParentCategoryModel> list) async {
    if (list.isEmpty) {
      print("⚠️ Tried to cache empty parent category list.");
      return;
    }

    try {
      await db.transaction((txn) async {
        await txn.delete('parent_categories');
        for (final item in list) {
          await txn.insert(
            'parent_categories',
            item.toDbMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      });
      print("✅ Cached ${list.length} parent categories successfully.");
    } catch (e) {
      print("❌ Failed to save parent categories cache: $e");
    }
  }
}
