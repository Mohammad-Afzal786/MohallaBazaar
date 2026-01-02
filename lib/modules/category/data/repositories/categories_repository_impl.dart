import 'package:mohalla_bazaar/modules/category/data/model/category_cache_model.dart';


import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../datasources/categories_local_data_source.dart';
import '../datasources/categories_remote_data_source.dart';

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

    // 🔹 Cache save
    final cacheList = response.data.expand((parent) {
      return parent.categories.map((cat) {
        return CategoryCacheModel(
          parentName: parent.parentName,
          parentId: parent.parentId,
          parentImage: parent.parentImage,
          parentSubtitle: parent.parentSubtitle,
          categoryId: cat.categoryId,
          categoryName: cat.name,
          image: cat.image,
          subtitle: cat.subtitle,
        );
      });
    }).toList();

    await local.saveCategories(cacheList);

    return response.data.map((parent) {
      return ParentCategoryEntity(
        parentName: parent.parentName,
        parentId: parent.parentId,
        parentImage: parent.parentImage,
        parentSubtitle: parent.parentSubtitle,
        categories: parent.categories.map((cat) {
          return CategoryEntity(
            id: cat.categoryId,
            name: cat.name,
            image: cat.image,
            subtitle: cat.subtitle,
            categoryId: cat.categoryId,
          );
        }).toList(),
      );
    }).toList();
  }

  @override
  Future<void> saveCategoriesToCache(List<ParentCategoryEntity> categories) async {
    final cacheList = categories.expand((parent) {
      return parent.categories.map((cat) {
        return CategoryCacheModel(
          parentName: parent.parentName,
          parentId: parent.parentId,
          parentImage: parent.parentImage,
          parentSubtitle: parent.parentSubtitle,
          categoryId: cat.categoryId,
          categoryName: cat.name,
          image: cat.image,
          subtitle: cat.subtitle,
        );
      });
    }).toList();

    await local.saveCategories(cacheList);
  }

  List<ParentCategoryEntity> _mapCacheToEntity(List<CategoryCacheModel> cacheList) {
    final Map<String, List<CategoryCacheModel>> grouped = {};
    for (var c in cacheList) {
      grouped.putIfAbsent(c.parentId, () => []).add(c);
    }

    return grouped.entries.map((e) {
      final first = e.value.first;
      return ParentCategoryEntity(
        parentName: first.parentName,
        parentId: first.parentId,
        parentImage: first.parentImage,
        parentSubtitle: first.parentSubtitle,
        categories: e.value.map((c) {
          return CategoryEntity(
            id: c.categoryId,
            name: c.categoryName,
            image: c.image,
            subtitle: c.subtitle,
            categoryId: c.categoryId,
          );
        }).toList(),
      );
    }).toList();
  }
}
