// Path: lib/features/category_details/data/models/category_details_cache_model.dart

class CategoryDetailsCacheModel {
  String categoryId; // Unique ID of category
  String jsonData;   // पूरा response JSON string
  DateTime lastUpdated;

  CategoryDetailsCacheModel({
    required this.categoryId,
    required this.jsonData,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  /// Convert object to map for SQLite insert
  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId, // table column name consistent with ParentCategoryDetails
      'jsonData': jsonData,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  /// Convert map from SQLite query to object
  factory CategoryDetailsCacheModel.fromMap(Map<String, dynamic> map) {
    return CategoryDetailsCacheModel(
      categoryId: map['category_id'] as String, // consistent column name
      jsonData: map['jsonData'] as String,
      lastUpdated: DateTime.parse(map['lastUpdated'] as String),
    );
  }
}
