// Path: lib/features/categories/data/models/category_cache_model.dart

class CategoryCacheModel {
  String parentName;
  String parentId;
  String parentImage;
  String parentSubtitle;

  String categoryId;
  String categoryName;
  String image;
  String subtitle;

  CategoryCacheModel({
    required this.parentName,
    required this.parentId,
    required this.parentImage,
    required this.parentSubtitle,
    required this.categoryId,
    required this.categoryName,
    required this.image,
    required this.subtitle,
  });

  // Convert object to map for SQLite insert
  Map<String, dynamic> toMap() {
    return {
      'parentName': parentName,
      'parentId': parentId,
      'parentImage': parentImage,
      'parentSubtitle': parentSubtitle,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'image': image,
      'subtitle': subtitle,
    };
  }

  // Convert map from SQLite query to object
  factory CategoryCacheModel.fromMap(Map<String, dynamic> map) {
    return CategoryCacheModel(
      parentName: map['parentName'] as String,
      parentId: map['parentId'] as String,
      parentImage: map['parentImage'] as String,
      parentSubtitle: map['parentSubtitle'] as String,
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      image: map['image'] as String,
      subtitle: map['subtitle'] as String,
    );
  }
}
