// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ParentCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

ParentCategory _$ParentCategoryFromJson(Map<String, dynamic> json) =>
    ParentCategory(
      parentName: json['parentCategoryName'] as String,
      parentId: json['parentCategoryId'] as String,
      parentImage: json['parentCategoryImage'] as String,
      parentSubtitle: json['parentCategorytitle'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParentCategoryToJson(ParentCategory instance) =>
    <String, dynamic>{
      'parentCategoryName': instance.parentName,
      'parentCategoryId': instance.parentId,
      'parentCategoryImage': instance.parentImage,
      'parentCategorytitle': instance.parentSubtitle,
      'categories': instance.categories,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['_id'] as String,
      name: json['categoryName'] as String,
      image: json['categoryimage'] as String,
      subtitle: json['categorysubtitle'] as String,
      categoryId: json['categoryId'] as String,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      '_id': instance.id,
      'categoryName': instance.name,
      'categoryimage': instance.image,
      'categorysubtitle': instance.subtitle,
      'categoryId': instance.categoryId,
    };
