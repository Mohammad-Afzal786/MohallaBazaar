class OrderItemEntity {
  final String productId;
  final String productName;
  final int quantity;
  final int price;
  final int discountPrice;
  final String productImage;
  final int totalProductPrice;
  final int totalDiscountPrice;
  final int productSaveAmount;
  final String productquantity;

  OrderItemEntity({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.discountPrice,
    required this.productImage,
    required this.totalProductPrice,
    required this.totalDiscountPrice,
    required this.productSaveAmount,
    required this.productquantity,
  });
}

class OrderEntity {
  final String orderId;
  final String status;
  final int currentStep;
  final int grandTotal;
  final String estimatedDelivery;
  final DateTime createdAt;
  final List<OrderItemEntity> items;
  final int cartItemCount;
  final int totalCartProductsAmount;
  final int totalCartDiscountAmount;
  final int totalSaveAmount;
  final int handlingCharge;
  final int deliveryCharge;

  OrderEntity({
    required this.orderId,
    required this.status,
      required this.currentStep,
    required this.grandTotal,
    required this.estimatedDelivery,
    required this.createdAt,
    required this.items,
    required this.cartItemCount,
    required this.totalCartProductsAmount,
    required this.totalCartDiscountAmount,
    required this.totalSaveAmount,
    required this.handlingCharge,
    required this.deliveryCharge,
  });
}

class OrderHistoryEntity {
  final String status;
  final String message;
  final List<OrderEntity> orders;

  OrderHistoryEntity({
    required this.status,
    required this.message,
    required this.orders,
  });
}
