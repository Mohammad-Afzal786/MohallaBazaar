// Path: lib/features/parent_categorydetails/domain/entities/parent_categorydetails_entity.dart
import 'product_entity.dart';

class ParentCategoryCategoryEntity {
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  final String categorySubtitle;
  final List<ProductEntity> products;

  ParentCategoryCategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.categorySubtitle,
    required this.products,
  });
}

class ParentCategoryDetailsEntity {
  final String parentCategoryId;
  final String parentCategoryName;
  final String parentCategoryImage;
  final String parentCategorySubtitle;
  final List<ParentCategoryCategoryEntity> categories;

  ParentCategoryDetailsEntity({
    required this.parentCategoryId,
    required this.parentCategoryName,
    required this.parentCategoryImage,
    required this.parentCategorySubtitle,
    required this.categories,
  });
}
