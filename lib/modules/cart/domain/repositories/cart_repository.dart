import 'package:mohalla_bazaar/modules/cart/domain/entities/cart_count_entity.dart';

import '../entities/cart_item_entity.dart';

abstract class CartRepository {
  /// Adds an item to cart and returns total cart items
  /// 
  Future<int> addToCart(CartItemEntity cartItem);

  Future<CartCountEntity> getCartCount(String userId);
}
