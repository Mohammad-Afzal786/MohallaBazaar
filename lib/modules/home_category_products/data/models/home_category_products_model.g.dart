// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_category_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCategoryProductsModel _$HomeCategoryProductsModelFromJson(
        Map<String, dynamic> json) =>
    HomeCategoryProductsModel(
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      categoryImage: json['categoryImage'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeCategoryProductsModelToJson(
        HomeCategoryProductsModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'categoryImage': instance.categoryImage,
      'products': instance.products,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productimage: json['productimage'] as String,
      productquantity: json['productquantity'] as String,
      productprice: (json['productprice'] as num?)?.toInt(),
      productdiscountPrice: (json['productdiscountPrice'] as num?)?.toInt(),
      productsaveAmount: (json['productsaveAmount'] as num?)?.toInt(),
      productrating: (json['productrating'] as num?)?.toInt(),
      productratag: (json['productratag'] as num?)?.toInt(),
      productDescription: json['productDescription'] as String?,
      productreviews: json['productreviews'] as String?,
      producttime: json['producttime'] as String?,
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
