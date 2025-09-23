// Path: lib/features/parent_categorydetails/data/models/parent_categorydetails_response.dart
import 'package:json_annotation/json_annotation.dart';
import 'parent_categorydetails_model.dart';

part 'parent_categorydetails_response.g.dart';

@JsonSerializable()
class ParentCategoryDetailsResponse {
  final String status;
  final bool success;
  final String message;
  final ParentCategoryData data;

  ParentCategoryDetailsResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ParentCategoryDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParentCategoryDetailsResponseToJson(this);
}

@JsonSerializable()
class ParentCategoryData {
  final String parentCategoryId;
  final String parentCategoryName;
  final String parentCategoryImage;
  final String parentCategorySubtitle;
  final List<CategoryModel> categories;

  ParentCategoryData({
    required this.parentCategoryId,
    required this.parentCategoryName,
    required this.parentCategoryImage,
    required this.parentCategorySubtitle,
    required this.categories,
  });

  factory ParentCategoryData.fromJson(Map<String, dynamic> json) =>
      _$ParentCategoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$ParentCategoryDataToJson(this);
}
