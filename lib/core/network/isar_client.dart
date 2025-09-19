// Path: lib/core/local/isar_client.dart
import 'package:isar/isar.dart';
import 'package:mohalla_bazaar/modules/category/data/model/category_cache_model.dart';
import 'package:path_provider/path_provider.dart';

class IsarClient {
  static late Isar _isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [CategoryCacheModelSchema],
      directory: dir.path,
    );
  }

  static Isar get instance => _isar;

  static Future<void> saveCategories(List<CategoryCacheModel> categories) async {
    await _isar.writeTxn(() async {
       await _isar.categoryCacheModels.clear(); // पुरानी cache clear
      await _isar.categoryCacheModels.putAll(categories);
       // Debug print
  await debugPrintCategories();
    });
  }
static Future<void> debugPrintCategories() async {
  final list = await _isar.categoryCacheModels.where().findAll();
  print("📦 Categories in cache: ${list.length}");
  for (final c in list) {
    print("➡️ ${c.id}: ${c.categoryName}");
  }
}

  static Future<List<CategoryCacheModel>> getCategories() async {
    return _isar.categoryCacheModels.where().findAll();
  }
  
}