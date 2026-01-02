import '../../domain/entities/parent_category_entity.dart';
import '../datasources/parent_category_local_data_source.dart';
import '../datasources/parent_category_remote_data_source.dart';

class ParentCategoryRepositoryImpl {
  final ParentCategoryLocalDataSource local;
  final ParentCategoryRemoteDataSource remote;

  ParentCategoryRepositoryImpl({required this.local, required this.remote});

  Future<List<ParentCategoryhomeEntity>> getCachedCategories() async {
    final cached = await local.getCachedCategories();
    return cached.map((m) => ParentCategoryhomeEntity.fromModel(m)).toList();
  }

  Future<List<ParentCategoryhomeEntity>> fetchAndCacheCategories() async {
    final fresh = await remote.fetchCategories();
    // Save to local cache
    await local.saveCategories(fresh);
    return fresh.map((m) => ParentCategoryhomeEntity.fromModel(m)).toList();
  }
}
