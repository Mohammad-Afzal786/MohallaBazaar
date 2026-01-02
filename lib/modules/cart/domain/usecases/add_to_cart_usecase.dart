import '../entities/cart_item_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<int> call(CartItemEntity cartItem) async {
    return await repository.addToCart(cartItem);
  }
}
