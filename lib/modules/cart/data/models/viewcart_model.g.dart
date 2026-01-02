// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewcart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      id: json['_id'] as String,
      parentCategoryId: json['parentCategoryId'] as String,
      categoryId: json['categoryId'] as String,
      productName: json['productName'] as String,
      productimage: json['productimage'] as String,
      productquantity: json['productquantity'] as String,
      productprice: json['productprice'] as num,
      productdiscountPrice: json['productdiscountPrice'] as num,
      productsaveAmount: json['productsaveAmount'] as num,
      productrating: (json['productrating'] as num).toDouble(),
      productratag: (json['productratag'] as num).toInt(),
      productDescription: json['productDescription'] as String,
      productreviews: json['productreviews'] as String,
      producttime: json['producttime'] as String,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'parentCategoryId': instance.parentCategoryId,
      'categoryId': instance.categoryId,
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
      'isActive': instance.isActive,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
