import 'package:json_annotation/json_annotation.dart';
part 'orderhistory_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderHistoryResponse {
  final String status;
  final String message;
  final List<OrderModel> data;

  OrderHistoryResponse({required this.status, required this.message, required this.data});

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final String orderId;
  final String status;
  final int grandTotal;
  final int currentStep;
  final String estimatedDelivery;
  final String createdAt;

  // 🔹 Billing summary
  final int cartItemCount;
  final int totalCartProductsAmount;
  final int totalCartDiscountAmount;
  final int totalSaveAmount;
  final int handlingCharge;
  final int deliveryCharge;

  final List<OrderItemModel> items;

  OrderModel({
    required this.orderId,
    required this.status,
    required this.grandTotal,
    required this.currentStep,
    required this.estimatedDelivery,
    required this.createdAt,
    required this.cartItemCount,
    required this.totalCartProductsAmount,
    required this.totalCartDiscountAmount,
    required this.totalSaveAmount,
    required this.handlingCharge,
    required this.deliveryCharge,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class OrderItemModel {
  final String productId;
  final String productName;
  final int quantity;
  final int price;
  final int discountPrice;
  final String productquantity;
  final String productimage;
  final int totalProductPrice;
  final int totalDiscountPrice;
  final int productsaveAmount;

  OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.discountPrice,
    required this.productquantity,
    required this.productimage,
    required this.totalProductPrice,
    required this.totalDiscountPrice,
    required this.productsaveAmount,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => _$OrderItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
