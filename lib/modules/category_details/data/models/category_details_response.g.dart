// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailsResponse _$CategoryDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryDetailsResponse(
      status: json['status'] as String,
      success: json['success'] as bool,
      message: json['message'] as String,
      productData: (json['productData'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDetailsResponseToJson(
        CategoryDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'productData': instance.productData,
    };
