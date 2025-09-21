// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorydetails_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailsResponse _$CategoryDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryDetailsResponse(
      status: json['status'] as String,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryDetailsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDetailsResponseToJson(
        CategoryDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

CategoryDetailsData _$CategoryDetailsDataFromJson(Map<String, dynamic> json) =>
    CategoryDetailsData(
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      image: json['image'] as String,
      subcategories: (json['subcategories'] as List<dynamic>)
          .map((e) => SubCategoryDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDetailsDataToJson(
        CategoryDetailsData instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'image': instance.image,
      'subcategories': instance.subcategories,
    };

SubCategoryDetails _$SubCategoryDetailsFromJson(Map<String, dynamic> json) =>
    SubCategoryDetails(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubCategoryDetailsToJson(SubCategoryDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'products': instance.products,
    };

ProductDetails _$ProductDetailsFromJson(Map<String, dynamic> json) =>
    ProductDetails(
      id: json['id'] as String,
      image: json['image'] as String,
      productName: json['productName'] as String,
      quantity: json['quantity'] as String,
      price: json['price'] as num,
      discountPrice: json['discountPrice'] as num,
      saveAmount: json['saveAmount'] as num,
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as String,
      time: json['time'] as String,
    );

Map<String, dynamic> _$ProductDetailsToJson(ProductDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'productName': instance.productName,
      'quantity': instance.quantity,
      'price': instance.price,
      'discountPrice': instance.discountPrice,
      'saveAmount': instance.saveAmount,
      'rating': instance.rating,
      'reviews': instance.reviews,
      'time': instance.time,
    };
