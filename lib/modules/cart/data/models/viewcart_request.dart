// Path: lib/features/viewcart/data/models/viewcart_request.dart
class ViewCartRequest {
  final String userId;

  ViewCartRequest({required this.userId});

  Map<String, dynamic> toJson() => {"userId": userId};
}
