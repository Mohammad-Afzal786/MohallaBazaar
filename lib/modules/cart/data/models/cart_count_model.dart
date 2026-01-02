import '../../domain/entities/cart_count_entity.dart';

class CartCountModel extends CartCountEntity {
  const CartCountModel({required super.count});

  factory CartCountModel.fromJson(Map<String, dynamic> json) {
    return CartCountModel(count: json['data']['cartItemCount'] ?? 0);
  }

  Map<String, dynamic> toJson() => {'count': count};
}
