// Path: lib/core/local/isar_client.dart
import 'package:isar/isar.dart';
import 'package:mohalla_bazaar/modules/categorydetails/data/model/categorydetails_cache_model.dart';
import 'package:path_provider/path_provider.dart';

// Models
import 'package:mohalla_bazaar/modules/category/data/model/category_cache_model.dart';

// Path: lib/core/local/isar_client.dart

// Models

class IsarClient {
  static late Isar _isar;

  /// Init
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        CategoryCacheModelSchema,
        CategoryDetailsCacheSchema,
      ],
      directory: dir.path,
    );
  }

  static Isar get instance => _isar;

  // ============================================================
  // 🔹 CATEGORY CACHE (HOME PAGE)
  // ============================================================

  static Future<void> saveCategories(List<CategoryCacheModel> categories) async {
    await _isar.writeTxn(() async {
      await _isar.categoryCacheModels.clear();
      await _isar.categoryCacheModels.putAll(categories);
      await debugPrintCategories();
    });
  }

  static Future<List<CategoryCacheModel>> getCategories() async {
    return _isar.categoryCacheModels.where().findAll();
  }

  static Future<void> debugPrintCategories() async {
    final list = await _isar.categoryCacheModels.where().findAll();
    print("📦 Categories in cache: ${list.length}");
    for (final c in list) {
      print("➡️ ${c.id}: ${c.categoryName}");
    }
  }

  // ============================================================
  // 🔹 CATEGORY DETAILS CACHE (JSON STORAGE)
  // ============================================================

  /// Save details
  static Future<void> saveCategoryDetails(String categoryId, String json) async {
    final cache = CategoryDetailsCache()
      ..categoryId = categoryId
      ..json = json
      ..updatedAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.categoryDetailsCaches
          .filter()
          .categoryIdEqualTo(categoryId)
          .deleteAll();

      await _isar.categoryDetailsCaches.put(cache);
    });
  }

  /// Get details JSON
  static Future<String?> getCategoryDetailsJson(String categoryId) async {
    final cache = await _isar.categoryDetailsCaches
        .filter()
        .categoryIdEqualTo(categoryId)
        .findFirst();
    return cache?.json;
  }

  /// Debug print
  static Future<void> debugPrintCaches() async {
    final list = await _isar.categoryDetailsCaches.where().findAll();
    print("📂 CategoryDetails caches: ${list.length}");
    for (final c in list) {
      print("➡️ categoryId=${c.categoryId}, updatedAt=${c.updatedAt}");
    }
  }
}
