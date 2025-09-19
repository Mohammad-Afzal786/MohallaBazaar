// Path: lib/features/categories/domain/entities/category_entity.dart
class SubCategoryEntity {
  final String id;
  final String name;
  final String image;

  SubCategoryEntity({required this.id, required this.name, required this.image});
}

class ParentCategoryEntity {
  final String parentName;
  final List<SubCategoryEntity> categories;

  ParentCategoryEntity({required this.parentName, required this.categories});
}



