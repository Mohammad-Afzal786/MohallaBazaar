import 'package:mohalla_bazaar/core/network/isar_client.dart';
import '../models/category_details_cache_model.dart';

abstract class CategoryDetailsLocalDataSource {
  Future<List<CategoryDetailsCacheModel>> getCachedProducts();
  Future<void> saveProducts(List<CategoryDetailsCacheModel> products);
}

class CategoryDetailsLocalDataSourceImpl
    implements CategoryDetailsLocalDataSource {
  @override
  Future<List<CategoryDetailsCacheModel>> getCachedProducts() {
    return IsarClient.getCategoryDetails();
  }

  @override
  Future<void> saveProducts(List<CategoryDetailsCacheModel> products) {
    return IsarClient.saveCategoryDetails(products);
  }
}
