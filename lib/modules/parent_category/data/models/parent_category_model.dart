class ParentCategoryModel {
  final String parentCategoryId;
  final String parentCategoryName;
  final String parentCategoryImage;
  final String parentCategorytitle;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ParentCategoryModel({
    required this.parentCategoryId,
    required this.parentCategoryName,
    required this.parentCategoryImage,
    required this.parentCategorytitle,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  /// From API JSON
  factory ParentCategoryModel.fromJson(Map<String, dynamic> json) {
    return ParentCategoryModel(
      parentCategoryId: json['parentCategoryId'] ?? '',
      parentCategoryName: json['parentCategoryName'] ?? '',
      parentCategoryImage: json['parentCategoryImage'] ?? '',
      parentCategorytitle: json['parentCategorytitle'] ?? '',
      isActive: (json['isActive'] is int
              ? json['isActive'] == 1
              : json['isActive'] == true) ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  /// Convert to Map for SQLite
  Map<String, dynamic> toDbMap() => {
        'parentCategoryId': parentCategoryId,
        'parentCategoryName': parentCategoryName,
        'parentCategoryImage': parentCategoryImage,
        'parentCategorytitle': parentCategorytitle,
        'isActive': isActive ? 1 : 0,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// From SQLite DB Map
  factory ParentCategoryModel.fromDb(Map<String, dynamic> db) {
    return ParentCategoryModel(
      parentCategoryId: db['parentCategoryId'] ?? '',
      parentCategoryName: db['parentCategoryName'] ?? '',
      parentCategoryImage: db['parentCategoryImage'] ?? '',
      parentCategorytitle: db['parentCategorytitle'] ?? '',
      isActive: db['isActive'] == 1,
      createdAt: db['createdAt'] != null
          ? DateTime.tryParse(db['createdAt'])
          : null,
      updatedAt: db['updatedAt'] != null
          ? DateTime.tryParse(db['updatedAt'])
          : null,
    );
  }

  /// Convert back to JSON (optional, for API)
  Map<String, dynamic> toJson() => {
        'parentCategoryId': parentCategoryId,
        'parentCategoryName': parentCategoryName,
        'parentCategoryImage': parentCategoryImage,
        'parentCategorytitle': parentCategorytitle,
        'isActive': isActive,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
