// Path: lib/features/viewcart/data/models/viewcart_cache_model.dart

class ViewCartCacheModel {
  String userId;       // Unique userId
  String jsonResponse; // पूरा response JSON string
  DateTime savedAt;

  ViewCartCacheModel({
    required this.userId,
    required this.jsonResponse,
    DateTime? savedAt,
  }) : savedAt = savedAt ?? DateTime.now();

  // Convert object to map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'jsonResponse': jsonResponse,
      'savedAt': savedAt.toIso8601String(),
    };
  }

  // Convert map from SQLite query to object
  factory ViewCartCacheModel.fromMap(Map<String, dynamic> map) {
    return ViewCartCacheModel(
      userId: map['userId'] as String,
      jsonResponse: map['jsonResponse'] as String,
      savedAt: DateTime.parse(map['savedAt'] as String),
    );
  }
}
