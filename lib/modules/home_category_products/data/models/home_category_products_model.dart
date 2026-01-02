import 'package:json_annotation/json_annotation.dart';


part 'home_category_products_model.g.dart';

@JsonSerializable()
class HomeCategoryProductsModel {
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  final List<ProductModel> products;

  HomeCategoryProductsModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.products,
  });

  factory HomeCategoryProductsModel.fromJson(Map<String, dynamic> json) =>
      _$HomeCategoryProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeCategoryProductsModelToJson(this);
}

@JsonSerializable()
class ProductModel {
  final String productId;
  final String productName;
  final String productimage;
  final String productquantity;
  final int? productprice;           // nullable
  final int? productdiscountPrice;   // nullable
  final int? productsaveAmount;      // nullable
  final int? productrating;
  final int? productratag;
  final String? productDescription;
  final String? productreviews;
  final String? producttime;
  final List<String>? productsimagedetails;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productimage,
    required this.productquantity,
    this.productprice,
    this.productdiscountPrice,
    this.productsaveAmount,
    this.productrating,
    this.productratag,
    this.productDescription,
    this.productreviews,
    this.producttime,
    this.productsimagedetails,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
