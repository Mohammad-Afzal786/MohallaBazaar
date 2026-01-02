// API request model
class OrderHistoryRequest {
  final String userId;

  OrderHistoryRequest({required this.userId});

  Map<String, dynamic> toJson() => {"userId": userId};
}
