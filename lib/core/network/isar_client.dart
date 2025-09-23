// Path: lib/core/local/isar_client.dart
import 'package:isar/isar.dart';
import 'package:mohalla_bazaar/modules/category/data/model/category_cache_model.dart';
import 'package:mohalla_bazaar/modules/category_details/data/models/category_details_cache_model.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/data/model/parent_categorydetails_cache_model.dart';
import 'package:path_provider/path_provider.dart';
// Models

class IsarClient {
  static late Isar _isar;

  /// Init
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        CategoryCacheModelSchema,
        ParentCategoryDetailsCacheModelSchema, // Added
        CategoryDetailsCacheModelSchema, // New table added
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
  // 🔹 PARENT CATEGORY DETAILS CACHE
  // ============================================================

static Future<void> saveParentCategoryDetails(List<ParentCategoryDetailsCacheModel> list) async {
    await _isar.writeTxn(() async {
      // Replace existing items for same parentCategoryId(s)
      await _isar.parentCategoryDetailsCacheModels.clear();
      await _isar.parentCategoryDetailsCacheModels.putAll(list);
    });
  }

  static Future<List<ParentCategoryDetailsCacheModel>> getParentCategoryDetails() async {
    return _isar.parentCategoryDetailsCacheModels.where().findAll();
  }


// ============================================================
// 🔹 CATEGORY DETAILS CACHE
// ============================================================

static Future<void> saveCategoryDetails(List<CategoryDetailsCacheModel> list) async {
    await _isar.writeTxn(() async {
      // Replace existing items for same parentCategoryId(s)
      await _isar.categoryDetailsCacheModels.clear();
      await _isar.categoryDetailsCacheModels.putAll(list);
       await debugPrintCategorieydetails();
    });
  }

  static Future<List<CategoryDetailsCacheModel>> getCategoryDetails() async {
    return _isar.categoryDetailsCacheModels.where().findAll();
  }

 static Future<void> debugPrintCategorieydetails() async {
    final list = await _isar.categoryDetailsCacheModels.where().findAll();
    print("📦 Categorieydetails in cache: ${list.length}");
    for (final c in list) {
      print("➡️ ${c.id}: ${c.categoryId}");
    }
  }

}
