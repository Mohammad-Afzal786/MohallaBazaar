// Path: lib/features/categories/data/models/parent_categorydetails_model.dart

// Path: lib/features/parent_categorydetails/data/models/parent_categorydetails_model.dart
//Explanation (हिंदी): Category और Product nested models — API के categories और products को map करता है।
import 'package:json_annotation/json_annotation.dart';

part 'parent_categorydetails_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  final String categorySubtitle;
  final List<ProductModel> products;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.categorySubtitle,
    required this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class ProductModel {
  final String productId;
  final String productName;
  final String productimage;
  final String productquantity;
  final int productprice;
  final int productdiscountPrice;
  final int productsaveAmount;
  final double productrating;
  final int productratag;
  final String productDescription;
  final String productreviews;
  final String producttime;
 final List<String>? productsimagedetails; // nullable
 
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
    required this.productsimagedetails
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
