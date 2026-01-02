import '../entities/home_category_products_entity.dart';

abstract class HomeCategoryProductsRepository {
  Future<List<HomeCategoryProductsEntity>> getCachedHomeCategoryProducts();
  Future<List<HomeCategoryProductsEntity>> fetchHomeCategoryProducts();
}
