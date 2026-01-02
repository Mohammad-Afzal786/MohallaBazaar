import '../entities/home_category_products_entity.dart';
import '../repositories/home_category_products_repository.dart';

class GetHomeCategoryProductsUseCase {
  final HomeCategoryProductsRepository repository;

  GetHomeCategoryProductsUseCase(this.repository);

  Future<List<HomeCategoryProductsEntity>> getCached() async {
    return repository.getCachedHomeCategoryProducts();
  }

  Future<List<HomeCategoryProductsEntity>> fetch() async {
    return repository.fetchHomeCategoryProducts();
  }
}
