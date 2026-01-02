

import 'package:mohalla_bazaar/core/network/sqlite_client.dart';

abstract class BannerLocalDataSource {
  Future<void> cacheBanners(String json);
  Future<String?> getCachedBanners();
}

class BannerLocalDataSourceImpl implements BannerLocalDataSource {
  @override
  Future<void> cacheBanners(String json) async {
    await SQLiteClient.savebannerCache(json);
  }

  @override
  Future<String?> getCachedBanners() async {
    return await SQLiteClient.getbannerCache();
  }
}
