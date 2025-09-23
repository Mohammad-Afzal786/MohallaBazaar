// Path: lib/features/categories/domain/entities/category_entity.dart
class CategoryEntity {
  final String id;
  final String name;
  final String image;
  final String subtitle;
  final String categoryId;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
   required this.subtitle,
    required this.categoryId,
  });
}

class ParentCategoryEntity {
  final String parentName;
  final String parentId;
  final String parentImage;
  final String parentSubtitle;
  final List<CategoryEntity> categories;

  ParentCategoryEntity({
    required this.parentName,
    required this.parentId,
    required this.parentImage,
    required this.parentSubtitle,
    required this.categories,
  });
}


