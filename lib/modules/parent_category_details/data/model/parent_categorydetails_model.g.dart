// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_categorydetails_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      categoryImage: json['categoryImage'] as String,
      categorySubtitle: json['categorySubtitle'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'categoryImage': instance.categoryImage,
      'categorySubtitle': instance.categorySubtitle,
      'products': instance.products,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productimage: json['productimage'] as String,
      productquantity: json['productquantity'] as String,
      productprice: (json['productprice'] as num).toInt(),
      productdiscountPrice: (json['productdiscountPrice'] as num).toInt(),
      productsaveAmount: (json['productsaveAmount'] as num).toInt(),
      productrating: (json['productrating'] as num).toDouble(),
      productratag: (json['productratag'] as num).toInt(),
      productDescription: json['productDescription'] as String,
      productreviews: json['productreviews'] as String,
      producttime: json['producttime'] as String,
      productsimagedetails: (json['productsimagedetails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productimage': instance.productimage,
      'productquantity': instance.productquantity,
      'productprice': instance.productprice,
      'productdiscountPrice': instance.productdiscountPrice,
      'productsaveAmount': instance.productsaveAmount,
      'productrating': instance.productrating,
      'productratag': instance.productratag,
      'productDescription': instance.productDescription,
      'productreviews': instance.productreviews,
      'producttime': instance.producttime,
      'productsimagedetails': instance.productsimagedetails,
    };
