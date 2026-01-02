class OrderItemEntity {
  final String productId;
  final String productName;
  final int quantity;
  final String productImage;
  final String productQuantity;
  final double price;
  final double discountPrice;
  final double totalProductPrice;
  final double totalDiscountPrice;
  final double productSaveAmount;

  const OrderItemEntity({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.productImage,
    required this.productQuantity,
    required this.price,
    required this.discountPrice,
    required this.totalProductPrice,
    required this.totalDiscountPrice,
    required this.productSaveAmount,
  });
}
