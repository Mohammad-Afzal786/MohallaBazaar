import '../entities/category_entity.dart';
import '../repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  /// 🔹 Pehle cache check karo
  Future<List<ParentCategoryEntity>> getCachedCategories() async {
    return repository.getCachedCategories();
  }

  /// 🔹 API se fresh data fetch karo
  Future<List<ParentCategoryEntity>> fetchCategories() async {
    final categories = await repository.fetchCategoriesFromApi();
    return categories;
  }

  /// 🔹 Cache update karo
  Future<void> saveCategoriesToCache(List<ParentCategoryEntity> categories) async {
    await repository.saveCategoriesToCache(categories);
  }
}
