class ParentCategoryDetailsCacheModel {
  String parentCategoryId; // Unique ID of parent category
  String jsonData;         
  DateTime lastUpdated;

  ParentCategoryDetailsCacheModel({
    required this.parentCategoryId,
    required this.jsonData,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  // Convert object to map for SQLite insert
  Map<String, dynamic> toMap() {
    return {
      'category_id': parentCategoryId, // <-- table column name
      'jsonData': jsonData,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  // Convert map from SQLite query to object
  factory ParentCategoryDetailsCacheModel.fromMap(Map<String, dynamic> map) {
    return ParentCategoryDetailsCacheModel(
      parentCategoryId: map['category_id'] as String, // <-- table column name
      jsonData: map['jsonData'] as String,
      lastUpdated: DateTime.parse(map['lastUpdated'] as String),
    );
  }
}
