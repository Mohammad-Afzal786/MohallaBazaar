// Path: lib/features/parent_categorydetails/domain/repositories/parent_categorydetails_repository.dart
import '../entities/parent_categorydetails_entity.dart';

abstract class ParentCategoryDetailsRepository {
  /// Cache से पहले देखो (null allowed)
  Future<ParentCategoryDetailsEntity?> getCachedParentCategoryDetails(String parentCategoryId);

  /// API से fetch करो और cache update करो
  Future<ParentCategoryDetailsEntity> fetchParentCategoryDetailsFromApi(String parentCategoryId);
}
