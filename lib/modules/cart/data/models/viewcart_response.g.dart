// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewcart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewCartData _$ViewCartDataFromJson(Map<String, dynamic> json) => ViewCartData(
      userId: json['userId'] as String,
      cartItemCount: (json['cartItemCount'] as num).toInt(),
      cartTotalAmount: json['cartTotalAmount'] as num,
      handlingCharge: json['handlingCharge'] as num,
      deliveryCharge: json['deliveryCharge'] as num,
      needToAddForFreeDelivery: json['needToAddForFreeDelivery'] as num,
      grandTotal: json['grandTotal'] as num,
      totalCartDiscountAmount: json['totalCartDiscountAmount'] as num,
      totalCartProductsAmount: json['totalCartProductsAmount'] as num,
      totalSaveAmount: json['totalSaveAmount'] as num,
      cartList: (json['cartList'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ViewCartDataToJson(ViewCartData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'cartItemCount': instance.cartItemCount,
      'cartTotalAmount': instance.cartTotalAmount,
      'handlingCharge': instance.handlingCharge,
      'deliveryCharge': instance.deliveryCharge,
      'needToAddForFreeDelivery': instance.needToAddForFreeDelivery,
      'grandTotal': instance.grandTotal,
      'totalCartDiscountAmount': instance.totalCartDiscountAmount,
      'totalCartProductsAmount': instance.totalCartProductsAmount,
      'totalSaveAmount': instance.totalSaveAmount,
      'cartList': instance.cartList,
    };

ViewCartResponse _$ViewCartResponseFromJson(Map<String, dynamic> json) =>
    ViewCartResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: ViewCartData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ViewCartResponseToJson(ViewCartResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
