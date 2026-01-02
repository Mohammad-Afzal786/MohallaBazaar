// Path: lib/features/viewcart/data/models/viewcart_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'viewcart_model.g.dart';

@JsonSerializable()
class CartItemModel {
  @JsonKey(name: "_id")
  final String id;
  final String parentCategoryId;
  final String categoryId;
  final String productName;
  final String productimage;
  final String productquantity;
  final num productprice;
  final num productdiscountPrice;
  final num productsaveAmount;
  final double productrating;
  final int productratag;
  final String productDescription;
  final String productreviews;
  final String producttime;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String productId;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.parentCategoryId,
    required this.categoryId,
    required this.productName,
    required this.productimage,
    required this.productquantity,
    required this.productprice,
    required this.productdiscountPrice,
    required this.productsaveAmount,
    required this.productrating,
    required this.productratag,
    required this.productDescription,
    required this.productreviews,
    required this.producttime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => _$CartItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
