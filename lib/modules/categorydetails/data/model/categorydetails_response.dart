// Path: lib/features/categories/data/models/categorydetails_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'categorydetails_response.g.dart';

@JsonSerializable()
class CategoryDetailsResponse {
  final String status;
  final bool success;
  final String message;
  final List<CategoryDetailsData> data;

  CategoryDetailsResponse({required this.status, required this.success, required this.message, required this.data});

  factory CategoryDetailsResponse.fromJson(Map<String, dynamic> json) => _$CategoryDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDetailsResponseToJson(this);
}

@JsonSerializable()
class CategoryDetailsData {
  final String categoryId;
  final String categoryName;
  final String image;
  final List<SubCategoryDetails> subcategories;

  CategoryDetailsData({required this.categoryId, required this.categoryName, required this.image, required this.subcategories});

  factory CategoryDetailsData.fromJson(Map<String, dynamic> json) => _$CategoryDetailsDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDetailsDataToJson(this);
}

@JsonSerializable()
class SubCategoryDetails {
  final String id;
  final String name;
  final String image;
  final List<ProductDetails> products;

  SubCategoryDetails({required this.id, required this.name, required this.image, required this.products});

  factory SubCategoryDetails.fromJson(Map<String, dynamic> json) => _$SubCategoryDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryDetailsToJson(this);
}

@JsonSerializable()
class ProductDetails {
  final String id;
  final String image;
  final String productName;
  final String quantity;
  final num price;
  final num discountPrice;
  final num saveAmount;
  final double rating;
  final String reviews;
  final String time;

  ProductDetails({
    required this.id,
    required this.image,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.discountPrice,
    required this.saveAmount,
    required this.rating,
    required this.reviews,
    required this.time,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => _$ProductDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailsToJson(this);
}
