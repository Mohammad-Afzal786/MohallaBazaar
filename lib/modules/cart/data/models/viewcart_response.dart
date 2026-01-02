// Path: lib/features/viewcart/data/models/viewcart_response.dart
import 'package:json_annotation/json_annotation.dart';
import 'viewcart_model.dart';

part 'viewcart_response.g.dart';

@JsonSerializable()
class ViewCartData {
  final String userId;
  final int cartItemCount;
  final num cartTotalAmount;
  final num handlingCharge;
  final num deliveryCharge;
  final num needToAddForFreeDelivery;
  final num grandTotal;
  final num totalCartDiscountAmount;
  final num totalCartProductsAmount;
  final num totalSaveAmount;
  final List<CartItemModel> cartList;

  ViewCartData({
    required this.userId,
    required this.cartItemCount,
    required this.cartTotalAmount,
    required this.handlingCharge,
    required this.deliveryCharge,
    required this.needToAddForFreeDelivery,
    required this.grandTotal,
    required this.totalCartDiscountAmount,
    required this.totalCartProductsAmount,
    required this.totalSaveAmount,
    required this.cartList,
  });

  factory ViewCartData.fromJson(Map<String, dynamic> json) =>
      _$ViewCartDataFromJson(json);
  Map<String, dynamic> toJson() => _$ViewCartDataToJson(this);
}

@JsonSerializable()
class ViewCartResponse {
  final String status;
  final String message;
  final ViewCartData data;

  ViewCartResponse({required this.status, required this.message, required this.data});

  factory ViewCartResponse.fromJson(Map<String, dynamic> json) =>
      _$ViewCartResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ViewCartResponseToJson(this);
}
