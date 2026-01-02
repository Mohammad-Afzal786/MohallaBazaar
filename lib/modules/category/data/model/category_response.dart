import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  final bool success;
  final String message;
  final List<ParentCategory> data;

  CategoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class ParentCategory {
  @JsonKey(name: "parentCategoryName")
  final String parentName;

  @JsonKey(name: "parentCategoryId")
  final String parentId;

  @JsonKey(name: "parentCategoryImage")
  final String parentImage;

  @JsonKey(name: "parentCategorytitle")
  final String parentSubtitle;

  final List<Category> categories;

  ParentCategory({
    required this.parentName,
    required this.parentId,
    required this.parentImage,
  required  this.parentSubtitle,
    required this.categories,
  });

  factory ParentCategory.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryFromJson(json);
}

@JsonSerializable()
class Category {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "categoryName")
  final String name;

  @JsonKey(name: "categoryimage")
  final String image;

  @JsonKey(name: "categorysubtitle")
  final String subtitle;

  @JsonKey(name: "categoryId")
  final String categoryId;

  Category({
    required this.id,
    required this.name,
    required this.image,
   required this.subtitle,
    required this.categoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
