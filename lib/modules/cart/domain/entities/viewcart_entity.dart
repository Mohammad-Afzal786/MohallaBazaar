// Path: lib/features/viewcart/domain/entities/viewcart_entity.dart

class CartItemEntity {
  final String id;
  final String parentCategoryId;
  final String categoryId;
  final String productId;
  final String productName;
  final String productImage;
  final String productQuantity;
  final int quantity;
  final num price;
  final num discountPrice;
  final num saveAmount;
  final double productRating;
  final int productRatag;
  final String productDescription;
  final String productReviews;
  final String productTime;
  final bool isActive;

  CartItemEntity({
    required this.id,
    required this.parentCategoryId,
    required this.categoryId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productQuantity,
    required this.quantity,
    required this.price,
    required this.discountPrice,
    required this.saveAmount,
    required this.productRating,
    required this.productRatag,
    required this.productDescription,
    required this.productReviews,
    required this.productTime,
    required this.isActive,
  });
}

class ViewCartEntity {
  final String userId;
  final int cartItemCount;
  final num cartTotalAmount;
  final num grandTotal;
  final num totalSaveAmount;
  final num handlingCharge;
  final num deliveryCharge;
  final num needToAddForFreeDelivery;
  final num totalCartDiscountAmount;
  final num totalCartProductsAmount;
  final List<CartItemEntity> cartList;

  ViewCartEntity({
    required this.userId,
    required this.cartItemCount,
    required this.cartTotalAmount,
    required this.grandTotal,
    required this.totalSaveAmount,
    required this.handlingCharge,
    required this.deliveryCharge,
    required this.needToAddForFreeDelivery,
    required this.totalCartDiscountAmount,
    required this.totalCartProductsAmount,
    required this.cartList,
  });
}
