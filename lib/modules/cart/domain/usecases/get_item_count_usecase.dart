import 'package:mohalla_bazaar/modules/cart/domain/entities/cart_count_entity.dart';
import 'package:mohalla_bazaar/modules/cart/domain/repositories/cart_repository.dart';


class GetCartCountUseCase {
  final CartRepository repository;
  GetCartCountUseCase(this.repository);

  Future<CartCountEntity> call(String userId) async {
    return await repository.getCartCount(userId);
  }
}
