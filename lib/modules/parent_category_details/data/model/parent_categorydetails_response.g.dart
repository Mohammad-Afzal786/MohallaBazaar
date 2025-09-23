// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_categorydetails_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentCategoryDetailsResponse _$ParentCategoryDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ParentCategoryDetailsResponse(
      status: json['status'] as String,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: ParentCategoryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParentCategoryDetailsResponseToJson(
        ParentCategoryDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

ParentCategoryData _$ParentCategoryDataFromJson(Map<String, dynamic> json) =>
    ParentCategoryData(
      parentCategoryId: json['parentCategoryId'] as String,
      parentCategoryName: json['parentCategoryName'] as String,
      parentCategoryImage: json['parentCategoryImage'] as String,
      parentCategorySubtitle: json['parentCategorySubtitle'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParentCategoryDataToJson(ParentCategoryData instance) =>
    <String, dynamic>{
      'parentCategoryId': instance.parentCategoryId,
      'parentCategoryName': instance.parentCategoryName,
      'parentCategoryImage': instance.parentCategoryImage,
      'parentCategorySubtitle': instance.parentCategorySubtitle,
      'categories': instance.categories,
    };
