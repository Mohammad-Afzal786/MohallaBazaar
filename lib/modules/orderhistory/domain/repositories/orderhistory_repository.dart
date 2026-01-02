import '../entities/orderhistory_entity.dart';

abstract class OrderHistoryRepository {
  /// Local cache se get kare
  Future<OrderHistoryEntity?> getCachedOrderHistory(String userId);

  /// Remote API se get kare aur cache update kare
  Future<OrderHistoryEntity> getRemoteOrderHistory(String userId);
}
