// Path: lib/features/categories/data/models/category_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  final bool success;
  final String message;
  final List<ParentCategory> data;

  CategoryResponse({required this.success, required this.message, required this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class ParentCategory {
  @JsonKey(name: "parentcategoryName")
  final String parentName;
  final List<SubCategory> categories;

  ParentCategory({required this.parentName, required this.categories});

  factory ParentCategory.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryFromJson(json);
}

@JsonSerializable()
class SubCategory {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "categoryName")
  final String name;
  final String image;

  SubCategory({required this.id, required this.name, required this.image});

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);
}
