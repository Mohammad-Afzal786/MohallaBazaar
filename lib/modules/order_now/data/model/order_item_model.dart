import 'package:json_annotation/json_annotation.dart';
import 'package:mohalla_bazaar/modules/order_now/domain/entities/order_item_entity.dart';


part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  final String productId;
  final String productName;
  final int quantity;
  final String productimage;
  final String productquantity;
  final double price;
  final double discountPrice;
  final double totalProductPrice;
  final double totalDiscountPrice;
  final double productsaveAmount;

  OrderItemModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.productimage,
    required this.productquantity,
    required this.price,
    required this.discountPrice,
    required this.totalProductPrice,
    required this.totalDiscountPrice,
    required this.productsaveAmount,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => _$OrderItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  OrderItemEntity toEntity() => OrderItemEntity(
        productId: productId,
        productName: productName,
        quantity: quantity,
        productImage: productimage,
        productQuantity: productquantity,
        price: price,
        discountPrice: discountPrice,
        totalProductPrice: totalProductPrice,
        totalDiscountPrice: totalDiscountPrice,
        productSaveAmount: productsaveAmount,
      );
}
