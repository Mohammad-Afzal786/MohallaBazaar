import 'package:mohalla_bazaar/core/network/sqlite_client.dart';



abstract class HomeCategoryProductsLocalDataSource {
  Future<void> cacheHomeCategoryProducts(String json);
  Future<String?> getCachedHomeCategoryProducts();
}

class HomeCategoryProductsLocalDataSourceImpl
    implements HomeCategoryProductsLocalDataSource {
  @override
  Future<void> cacheHomeCategoryProducts(String json) async {
    await SQLiteClient.saveCache(json);
  }

  @override
  Future<String?> getCachedHomeCategoryProducts() async {
    return await SQLiteClient.getCache();
  }
}
