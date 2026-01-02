import '../entities/orderhistory_entity.dart';
import '../repositories/orderhistory_repository.dart';

class GetOrderHistoryUseCase {
  final OrderHistoryRepository repository;

  GetOrderHistoryUseCase(this.repository);

  /// Sirf cached/local se fetch kare
  Future<OrderHistoryEntity?> getCachedOrderHistory(String userId) {
    return repository.getCachedOrderHistory(userId);
  }

  /// Remote se fresh fetch kare + cache update kare
  Future<OrderHistoryEntity> getRemoteOrderHistory(String userId) {
    return repository.getRemoteOrderHistory(userId);
  }
}
