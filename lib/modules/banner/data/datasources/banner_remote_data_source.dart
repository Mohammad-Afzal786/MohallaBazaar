import '../../../../core/network/api_client.dart';
import '../models/banner_response.dart';

abstract class BannerRemoteDataSource {
  Future<BannerResponse> fetchBanners();
}

class BannerRemoteDataSourceImpl implements BannerRemoteDataSource {
  final ApiClient apiClient;
  BannerRemoteDataSourceImpl(this.apiClient);

  @override
  Future<BannerResponse> fetchBanners() => apiClient.getBanners();
}
