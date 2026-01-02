import 'package:json_annotation/json_annotation.dart';
import 'order_item_model.dart'; // ✅ correct relative path
import '../../domain/entities/order_entity.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String status;
  final String message;
  final String orderId;
  final int cartItemCount;
  final double totalCartProductsAmount;
  final double totalCartDiscountAmount;
  final double totalSaveAmount;
  final double handlingCharge;
  final double deliveryCharge;
  final double grandTotal;
  final String estimatedDelivery;
  final List<OrderItemModel> items;

  OrderModel({
    this.status = "",
    this.message = "",
    this.orderId = "",
    this.cartItemCount = 0,
    this.totalCartProductsAmount = 0,
    this.totalCartDiscountAmount = 0,
    this.totalSaveAmount = 0,
    this.handlingCharge = 0,
    this.deliveryCharge = 0,
    this.grandTotal = 0,
    this.estimatedDelivery = "",
    this.items = const [],
  });

  /// ✅ Custom fromJson to handle API response where actual order is inside 'data'
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    return OrderModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      orderId: data['orderId'] ?? '',
      cartItemCount: data['cartItemCount'] ?? 0,
      totalCartProductsAmount: (data['totalCartProductsAmount'] ?? 0).toDouble(),
      totalCartDiscountAmount: (data['totalCartDiscountAmount'] ?? 0).toDouble(),
      totalSaveAmount: (data['totalSaveAmount'] ?? 0).toDouble(),
      handlingCharge: (data['handlingCharge'] ?? 0).toDouble(),
      deliveryCharge: (data['deliveryCharge'] ?? 0).toDouble(),
      grandTotal: (data['grandTotal'] ?? 0).toDouble(),
      estimatedDelivery: data['estimatedDelivery'] ?? '',
      items: data['items'] != null
          ? List<OrderItemModel>.from(
              (data['items'] as List).map((x) => OrderItemModel.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderEntity toEntity() => OrderEntity(
        orderId: orderId,
        cartItemCount: cartItemCount,
        totalCartProductsAmount: totalCartProductsAmount,
        totalCartDiscountAmount: totalCartDiscountAmount,
        totalSaveAmount: totalSaveAmount,
        handlingCharge: handlingCharge,
        deliveryCharge: deliveryCharge,
        grandTotal: grandTotal,
        status: status,
        estimatedDelivery: estimatedDelivery,
        items: items.map((e) => e.toEntity()).toList(),
      );

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, cartItemCount: $cartItemCount, grandTotal: $grandTotal)';
  }
}
