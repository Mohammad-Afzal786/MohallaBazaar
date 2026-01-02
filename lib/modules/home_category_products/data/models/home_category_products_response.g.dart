// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_category_products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCategoryProductsResponse _$HomeCategoryProductsResponseFromJson(
        Map<String, dynamic> json) =>
    HomeCategoryProductsResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              HomeCategoryProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeCategoryProductsResponseToJson(
        HomeCategoryProductsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
