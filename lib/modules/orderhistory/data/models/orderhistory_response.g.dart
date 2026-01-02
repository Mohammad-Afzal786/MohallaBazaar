// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderhistory_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryResponse _$OrderHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    OrderHistoryResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderHistoryResponseToJson(
        OrderHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      orderId: json['orderId'] as String,
      status: json['status'] as String,
      grandTotal: (json['grandTotal'] as num).toInt(),
      currentStep: (json['currentStep'] as num).toInt(),
      estimatedDelivery: json['estimatedDelivery'] as String,
      createdAt: json['createdAt'] as String,
      cartItemCount: (json['cartItemCount'] as num).toInt(),
      totalCartProductsAmount: (json['totalCartProductsAmount'] as num).toInt(),
      totalCartDiscountAmount: (json['totalCartDiscountAmount'] as num).toInt(),
      totalSaveAmount: (json['totalSaveAmount'] as num).toInt(),
      handlingCharge: (json['handlingCharge'] as num).toInt(),
      deliveryCharge: (json['deliveryCharge'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'status': instance.status,
      'grandTotal': instance.grandTotal,
      'currentStep': instance.currentStep,
      'estimatedDelivery': instance.estimatedDelivery,
      'createdAt': instance.createdAt,
      'cartItemCount': instance.cartItemCount,
      'totalCartProductsAmount': instance.totalCartProductsAmount,
      'totalCartDiscountAmount': instance.totalCartDiscountAmount,
      'totalSaveAmount': instance.totalSaveAmount,
      'handlingCharge': instance.handlingCharge,
      'deliveryCharge': instance.deliveryCharge,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      discountPrice: (json['discountPrice'] as num).toInt(),
      productquantity: json['productquantity'] as String,
      productimage: json['productimage'] as String,
      totalProductPrice: (json['totalProductPrice'] as num).toInt(),
      totalDiscountPrice: (json['totalDiscountPrice'] as num).toInt(),
      productsaveAmount: (json['productsaveAmount'] as num).toInt(),
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'quantity': instance.quantity,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'productquantity': instance.productquantity,
      'productimage': instance.productimage,
      'totalProductPrice': instance.totalProductPrice,
      'totalDiscountPrice': instance.totalDiscountPrice,
      'productsaveAmount': instance.productsaveAmount,
    };
