import 'dart:convert';
import '../../domain/entities/banner_entity.dart';
import '../../domain/repositories/banner_repository.dart';
import '../datasources/banner_local_data_source.dart';
import '../datasources/banner_remote_data_source.dart';
import '../models/banner_model.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource remoteDataSource;
  final BannerLocalDataSource localDataSource;

  BannerRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<List<BannerEntity>> getCachedBanners() async {
    final json = await localDataSource.getCachedBanners();
    if (json != null) {
      final List list = jsonDecode(json);
      return list.map((e) => BannerEntity.fromModel(BannerModel.fromJson(e))).toList();
    }
    return [];
  }

  @override
  Future<List<BannerEntity>> fetchBanners() async {
    final response = await remoteDataSource.fetchBanners();

    // Cache save
    final json = jsonEncode(response.banners.map((e) => e.toJson()).toList());
    await localDataSource.cacheBanners(json);

    return response.banners.map((e) => BannerEntity.fromModel(e)).toList();
  }
}
