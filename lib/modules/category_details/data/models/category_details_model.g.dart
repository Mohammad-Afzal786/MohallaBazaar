// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productimage: json['productimage'] as String,
      productquantity: json['productquantity'] as String,
      productprice: (json['productprice'] as num).toDouble(),
      productdiscountPrice: (json['productdiscountPrice'] as num).toDouble(),
      productsaveAmount: (json['productsaveAmount'] as num).toDouble(),
      productrating: (json['productrating'] as num).toDouble(),
      productratag: (json['productratag'] as num).toInt(),
      productDescription: json['productDescription'] as String,
      productreviews: json['productreviews'] as String,
      producttime: json['producttime'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productimage': instance.productimage,
      'productquantity': instance.productquantity,
      'productprice': instance.productprice,
      'productdiscountPrice': instance.productdiscountPrice,
      'productsaveAmount': instance.productsaveAmount,
      'productrating': instance.productrating,
      'productratag': instance.productratag,
      'productDescription': instance.productDescription,
      'productreviews': instance.productreviews,
      'producttime': instance.producttime,
    };
