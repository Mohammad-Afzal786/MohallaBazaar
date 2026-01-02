import '../entities/category_details_entity.dart';
import '../repositories/category_details_repository.dart';

/// 🔹 UseCase layer — Repository को wrap करता है
class CategoryDetailsUseCase {
  final CategoryDetailsRepository repository;

  CategoryDetailsUseCase(this.repository);

 
  /// 🔹 Pehle cache check karo
  Future<List<ProductEntity>> getCachedProducts(String categoryId) async {
    // Repository already categoryId ke basis pe data deta hai
    return await repository.getProducts(categoryId);
  }


  /// 🔹 API fetch + cache update
  Future<List<ProductEntity>> fetchProducts(String categoryId) async {
    return repository.fetchProductsFromApi(categoryId);
  }

  /// 🔹 Cache me manually save karo
  Future<void> saveProductsToCache(
      String categoryId, List<ProductEntity> products) async {
    await repository.saveProductsToCache(categoryId, products);
  }
}
