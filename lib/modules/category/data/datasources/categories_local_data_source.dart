// Path: lib/features/categories/data/datasources/categories_local_data_source.dart
import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import 'package:mohalla_bazaar/modules/category/data/model/category_cache_model.dart';

abstract class CategoriesLocalDataSource {
  Future<List<CategoryCacheModel>> getCategories();
  Future<void> saveCategories(List<CategoryCacheModel> categories);

  /// 🔹 Stream for live updates
  Stream<List<CategoryCacheModel>> watchCategories();
}

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  @override
  Future<List<CategoryCacheModel>> getCategories() async {
    final db = SQLiteClient.instance;
    final maps = await db.query('categories');
    return maps.map((m) => CategoryCacheModel.fromMap(m)).toList();
  }

  @override
  Future<void> saveCategories(List<CategoryCacheModel> categories) async {
    final db = SQLiteClient.instance;
    await db.transaction((txn) async {
      await txn.delete('categories'); // पुरानी cache clear
      for (var c in categories) {
        await txn.insert('categories', c.toMap());
      }
    });
  }

  @override
  Stream<List<CategoryCacheModel>> watchCategories() async* {
    // SQLite में live stream support नहीं है, इसे poll कर सकते हैं
    while (true) {
      final categories = await getCategories();
      yield categories;
      await Future.delayed(const Duration(seconds: 2)); // polling interval
    }
  }
}
