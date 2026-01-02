import 'package:mohalla_bazaar/modules/cart/domain/entities/cart_count_entity.dart';


import '../repositories/cart_repository.dart';

class GetCartCountUseCase {
  final CartRepository repository;
  GetCartCountUseCase(this.repository);

  Future<CartCountEntity> call(String userId) {
    return repository.getCartCount(userId);
  }
}
