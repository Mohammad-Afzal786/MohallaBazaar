// Path: lib/features/categories/domain/repositories/categorydetails_repository.dart
import 'package:mohalla_bazaar/modules/categorydetails/domain/entities/categorydetails_entity.dart';

abstract class CategoryDetailsRepository {
  /// Returns cached details if present (may return null)
  Future<CategoryDetailsEntity?> getCachedCategoryDetails(String categoryId);

  /// Fetch fresh details from API and update cache
  Future<CategoryDetailsEntity> fetchCategoryDetailsFromApi(String categoryId);
}
