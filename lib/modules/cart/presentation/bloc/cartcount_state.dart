abstract class CartCountState {}

class CartCountInitial extends CartCountState {}

class CartCountLoading extends CartCountState {}

class CartCountLoaded extends CartCountState {
  final int count;
  CartCountLoaded(this.count);
}

class CartCountError extends CartCountState {
  final String message;
  CartCountError(this.message);
}
