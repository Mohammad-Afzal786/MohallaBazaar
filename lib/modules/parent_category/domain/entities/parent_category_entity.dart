import '../../data/models/parent_category_model.dart';

class ParentCategoryhomeEntity {
  final String parentCategoryId;
  final String parentCategoryName;
  final String parentCategoryImage;
  final String parentCategorytitle;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ParentCategoryhomeEntity({
    required this.parentCategoryId,
    required this.parentCategoryName,
    required this.parentCategoryImage,
    required this.parentCategorytitle,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory ParentCategoryhomeEntity.fromModel(ParentCategoryModel model) {
    return ParentCategoryhomeEntity(
      parentCategoryId: model.parentCategoryId,
      parentCategoryName: model.parentCategoryName,
      parentCategoryImage: model.parentCategoryImage,
      parentCategorytitle: model.parentCategorytitle,
      isActive: model.isActive,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
}
