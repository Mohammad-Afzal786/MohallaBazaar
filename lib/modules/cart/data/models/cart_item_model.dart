import '../../domain/entities/cart_item_entity.dart';

class CartItemModel extends CartItemEntity {
  CartItemModel({
    required super.userId,
    required super.productId,
   
    required super.action, // ✅ add action
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        userId: json['userId'],
        productId: json['productId'],
      
         action: json['action'], // ✅ parse action
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'productId': productId,
         'action': action, // ✅ include action in json
      };
}
