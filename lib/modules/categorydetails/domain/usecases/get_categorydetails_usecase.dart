// Path: lib/features/categories/domain/usecases/get_categorydetails_usecase.dart
import 'package:mohalla_bazaar/modules/categorydetails/domain/entities/categorydetails_entity.dart';
import 'package:mohalla_bazaar/modules/categorydetails/domain/repositories/categorydetails_repository.dart';

class GetCategoryDetailsUseCase {
  final CategoryDetailsRepository repository;

  GetCategoryDetailsUseCase(this.repository);

  Future<CategoryDetailsEntity?> getCached(String categoryId) {
    return repository.getCachedCategoryDetails(categoryId);
  }

  Future<CategoryDetailsEntity> fetchFresh(String categoryId) {
    return repository.fetchCategoryDetailsFromApi(categoryId);
  }
}
