abstract class CartCountEvent {}

class LoadCartCount extends CartCountEvent {
  final String userId;
  LoadCartCount(this.userId);
}
