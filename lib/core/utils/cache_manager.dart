import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyCacheManager extends CacheManager {
  static const key = "myCachedImages";

  static final MyCacheManager _instance = MyCacheManager._();

  factory MyCacheManager() => _instance;

  MyCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 30), // cache valid 30 days
            maxNrOfCacheObjects: 700,               // max 700 files
          ),
        );
}
