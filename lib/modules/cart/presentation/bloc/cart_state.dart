abstract class CartState {
  final int totalItems;
  const CartState({this.totalItems = 0});
}

class CartInitial extends CartState {
  CartInitial() : super(totalItems: 0);
}

class CartLoading extends CartState {
  CartLoading({super.totalItems});
}

class CartSuccess extends CartState {}


class CartFailure extends CartState {
  final String error;
  CartFailure(this.error, );
}
