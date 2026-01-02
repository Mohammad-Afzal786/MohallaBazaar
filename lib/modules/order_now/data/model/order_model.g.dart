// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      status: json['status'] as String? ?? "",
      message: json['message'] as String? ?? "",
      orderId: json['orderId'] as String? ?? "",
      cartItemCount: (json['cartItemCount'] as num?)?.toInt() ?? 0,
      totalCartProductsAmount:
          (json['totalCartProductsAmount'] as num?)?.toDouble() ?? 0,
      totalCartDiscountAmount:
          (json['totalCartDiscountAmount'] as num?)?.toDouble() ?? 0,
      totalSaveAmount: (json['totalSaveAmount'] as num?)?.toDouble() ?? 0,
      handlingCharge: (json['handlingCharge'] as num?)?.toDouble() ?? 0,
      deliveryCharge: (json['deliveryCharge'] as num?)?.toDouble() ?? 0,
      grandTotal: (json['grandTotal'] as num?)?.toDouble() ?? 0,
      estimatedDelivery: json['estimatedDelivery'] as String? ?? "",
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'orderId': instance.orderId,
      'cartItemCount': instance.cartItemCount,
      'totalCartProductsAmount': instance.totalCartProductsAmount,
      'totalCartDiscountAmount': instance.totalCartDiscountAmount,
      'totalSaveAmount': instance.totalSaveAmount,
      'handlingCharge': instance.handlingCharge,
      'deliveryCharge': instance.deliveryCharge,
      'grandTotal': instance.grandTotal,
      'estimatedDelivery': instance.estimatedDelivery,
      'items': instance.items,
    };
