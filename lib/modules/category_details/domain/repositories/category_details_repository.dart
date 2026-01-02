import '../../domain/entities/category_details_entity.dart';

abstract class CategoryDetailsRepository {
  /// 🔹 Cache से data fetch
  Future<List<ProductEntity>> getProducts(String categoryId);

  /// 🔹 API से fresh data fetch + cache update
  Future<List<ProductEntity>> fetchProductsFromApi(String categoryId);

  /// 🔹 Manually cache update
  Future<void> saveProductsToCache(
      String categoryId, List<ProductEntity> products);
}
