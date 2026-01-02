import 'package:mohalla_bazaar/modules/cart/domain/entities/cart_item_entity.dart';

abstract class CartEvent {}

class AddCartItemEvent extends CartEvent {
  final CartItemEntity cartItem;

  AddCartItemEvent(this.cartItem);
}
class LoadCartTotalEvent extends CartEvent {
  final String userId;
  LoadCartTotalEvent(this.userId);
}
