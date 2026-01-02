// Cache model - SQLite ke liye
class OrderHistoryCacheModel {
  final String userId;
  final String jsonResponse;
  final DateTime savedAt;

  OrderHistoryCacheModel({
    required this.userId,
    required this.jsonResponse,
    required this.savedAt,
  });

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "jsonResponse": jsonResponse,
        "savedAt": savedAt.toIso8601String(),
      };

  factory OrderHistoryCacheModel.fromMap(Map<String, dynamic> map) =>
      OrderHistoryCacheModel(
        userId: map['userId'],
        jsonResponse: map['jsonResponse'],
        savedAt: DateTime.parse(map['savedAt']),
      );
}
