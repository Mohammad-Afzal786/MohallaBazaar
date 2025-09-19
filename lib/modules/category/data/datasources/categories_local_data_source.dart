// Path: lib/features/categories/data/datasources/categories_local_data_source.dart
import 'package:mohalla_bazaar/core/network/isar_client.dart';
import 'package:mohalla_bazaar/modules/category/data/model/category_cache_model.dart';

abstract class CategoriesLocalDataSource {
  Future<List<CategoryCacheModel>> getCategories();
  Future<void> saveCategories(List<CategoryCacheModel> categories);

  /// 🔹 Stream for live updates
  Stream<List<CategoryCacheModel>> watchCategories();
}

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  @override
  Future<List<CategoryCacheModel>> getCategories() {
    return IsarClient.getCategories();
  }

  @override
  Future<void> saveCategories(List<CategoryCacheModel> categories) {
    return IsarClient.saveCategories(categories);
    
  }

  @override
  Stream<List<CategoryCacheModel>> watchCategories() {
    // watchLazy() triggers every time collection changes
    return IsarClient.instance.categoryCacheModels.watchLazy().asyncMap(
          (_) => IsarClient.getCategories(),
        );
  }
}
