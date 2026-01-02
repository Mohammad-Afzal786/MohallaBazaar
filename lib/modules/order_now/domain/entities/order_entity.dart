import 'package:mohalla_bazaar/modules/order_now/domain/entities/order_item_entity.dart';

class OrderEntity {
  final String orderId;
  final int cartItemCount;
  final double totalCartProductsAmount;
  final double totalCartDiscountAmount;
  final double totalSaveAmount;
  final double handlingCharge;
  final double deliveryCharge;
  final double grandTotal;
  final String status;
  final String estimatedDelivery;
  final List<OrderItemEntity> items; // ✅ Add this

  const OrderEntity({
    required this.orderId,
    required this.cartItemCount,
    required this.totalCartProductsAmount,
    required this.totalCartDiscountAmount,
    required this.totalSaveAmount,
    required this.handlingCharge,
    required this.deliveryCharge,
    required this.grandTotal,
    required this.status,
    required this.estimatedDelivery,
    required this.items, // ✅ Initialize here
  });
}
