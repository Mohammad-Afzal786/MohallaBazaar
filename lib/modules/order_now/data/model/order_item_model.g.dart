// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: (json['quantity'] as num).toInt(),
      productimage: json['productimage'] as String,
      productquantity: json['productquantity'] as String,
      price: (json['price'] as num).toDouble(),
      discountPrice: (json['discountPrice'] as num).toDouble(),
      totalProductPrice: (json['totalProductPrice'] as num).toDouble(),
      totalDiscountPrice: (json['totalDiscountPrice'] as num).toDouble(),
      productsaveAmount: (json['productsaveAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'quantity': instance.quantity,
      'productimage': instance.productimage,
      'productquantity': instance.productquantity,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'totalProductPrice': instance.totalProductPrice,
      'totalDiscountPrice': instance.totalDiscountPrice,
      'productsaveAmount': instance.productsaveAmount,
    };
