// lib/features/categories/domain/repositories/categories_repository.dart
import '../entities/category_entity.dart';

abstract class CategoriesRepository {
  /// 🔹 Turant cache se data de
  Future<List<ParentCategoryEntity>> getCachedCategories();

  /// 🔹 API se fresh data fetch karo
  Future<List<ParentCategoryEntity>> fetchCategoriesFromApi();

  /// 🔹 Cache me data save karo
  Future<void> saveCategoriesToCache(List<ParentCategoryEntity> categories);
}

