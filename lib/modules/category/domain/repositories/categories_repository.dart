// lib/features/categories/domain/repositories/categories_repository.dart
import '../entities/category_entity.dart';

abstract class CategoriesRepository {
  Future<List<ParentCategoryEntity>> getCachedCategories();
  Future<List<ParentCategoryEntity>> fetchCategoriesFromApi();
  Future<void> saveCategoriesToCache(List<ParentCategoryEntity> categories);
}
