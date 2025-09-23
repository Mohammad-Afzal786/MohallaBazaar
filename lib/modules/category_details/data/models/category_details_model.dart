import 'package:json_annotation/json_annotation.dart';

part 'category_details_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String productId;
  final String productName;
  final String productimage;
  final String productquantity;
  final double productprice;
  final double productdiscountPrice;
  final double productsaveAmount;
  final double productrating;
  final int productratag;
  final String productDescription;
  final String productreviews;
  final String producttime;

  ProductModel({
    required this.productId,
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
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
