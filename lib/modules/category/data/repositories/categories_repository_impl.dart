import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_local_data_source.dart';
import '../datasources/categories_remote_data_source.dart';
import '../model/category_cache_model.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remote;
  final CategoriesLocalDataSource local;

  CategoriesRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<ParentCategoryEntity>> getCachedCategories() async {
    final localData = await local.getCategories();
    return _mapCacheToEntity(localData);
  }

  @override
  Future<List<ParentCategoryEntity>> fetchCategoriesFromApi() async {
    final response = await remote.fetchCategories();

    // Cache me save karo
    final cacheList = response.data
        .expand((parent) => parent.categories.map((sub) => CategoryCacheModel()
          ..parentName = parent.parentName
          ..categoryId = sub.id
          ..categoryName = sub.name
          ..image = sub.image))
        .toList();

    await local.saveCategories(cacheList);

    return response.data
        .map((parent) => ParentCategoryEntity(
              parentName: parent.parentName,
              categories: parent.categories
                  .map((sub) => SubCategoryEntity(
                        id: sub.id,
                        name: sub.name,
                        image: sub.image,
                      ))
                  .toList(),
            ))
        .toList();
  }

  @override
  Future<void> saveCategoriesToCache(List<ParentCategoryEntity> categories) async {
    final cacheList = categories
        .expand((parent) => parent.categories.map((sub) => CategoryCacheModel()
          ..parentName = parent.parentName
          ..categoryId = sub.id
          ..categoryName = sub.name
          ..image = sub.image))
        .toList();

    await local.saveCategories(cacheList);
  }

  List<ParentCategoryEntity> _mapCacheToEntity(List<CategoryCacheModel> cacheList) {
    final Map<String, List<SubCategoryEntity>> map = {};
    for (var c in cacheList) {
      map.putIfAbsent(c.parentName, () => []).add(
            SubCategoryEntity(id: c.categoryId, name: c.categoryName, image: c.image),
          );
    }
    return map.entries
        .map((e) => ParentCategoryEntity(parentName: e.key, categories: e.value))
        .toList();
  }
}
