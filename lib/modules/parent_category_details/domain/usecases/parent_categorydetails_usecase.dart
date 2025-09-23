// Path: lib/features/parent_categorydetails/domain/usecases/parent_categorydetails_usecase.dart
import '../entities/parent_categorydetails_entity.dart';
import '../repositories/parent_categorydetails_repository.dart';

class ParentCategoryDetailsUseCase {
  final ParentCategoryDetailsRepository repository;

  ParentCategoryDetailsUseCase(this.repository);

  Future<ParentCategoryDetailsEntity?> getCached(String parentCategoryId) {
    return repository.getCachedParentCategoryDetails(parentCategoryId);
  }

  Future<ParentCategoryDetailsEntity> fetchFresh(String parentCategoryId) {
    return repository.fetchParentCategoryDetailsFromApi(parentCategoryId);
  }
}
