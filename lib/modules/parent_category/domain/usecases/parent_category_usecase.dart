import '../entities/parent_category_entity.dart';
import '../../data/repositories/parent_category_repository_impl.dart';

class ParentCategoryUseCase {
  final ParentCategoryRepositoryImpl repository;

  ParentCategoryUseCase(this.repository);

  Future<List<ParentCategoryhomeEntity>> getCachedCategories() async {
    return repository.getCachedCategories();
  }

  Future<List<ParentCategoryhomeEntity>> fetchAndCacheCategories() async {
    return repository.fetchAndCacheCategories();
  }
}
