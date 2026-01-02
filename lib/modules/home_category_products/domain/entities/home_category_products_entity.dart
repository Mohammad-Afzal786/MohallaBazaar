import '../../data/models/home_category_products_model.dart';

class HomeCategoryProductsEntity {
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  final List<ProductEntity> products;

  HomeCategoryProductsEntity({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.products,
  });

  factory HomeCategoryProductsEntity.fromModel(HomeCategoryProductsModel model) {
    return HomeCategoryProductsEntity(
      categoryId: model.categoryId,
      categoryName: model.categoryName,
      categoryImage: model.categoryImage,
      products: model.products
          .map((p) => ProductEntity.fromModel(p))
          .toList(),
    );
  }

  /// ✅ Add this method
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'products': products.map((p) => p.toJson()).toList(),
    };
  }
}

class ProductEntity {
  final String productId;
  final String productName;
  final String productimage;
  final String productquantity;
  final int? productprice;           // nullable
  final int? productdiscountPrice;   // nullable
  final int? productsaveAmount;      // nullable
  final int? productrating;          // nullable
  final int? productratag;           // nullable
  final String? productDescription;  // nullable
  final String? productreviews;      // nullable
  final String? producttime;         // nullable
  final List<String>? productsimagedetails; // nullable

  ProductEntity({
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

  factory ProductEntity.fromModel(ProductModel model) {
    return ProductEntity(
      productId: model.productId,
      productName: model.productName,
      productimage: model.productimage,
      productquantity: model.productquantity,
      productprice: model.productprice,
      productdiscountPrice: model.productdiscountPrice,
      productsaveAmount: model.productsaveAmount,
      productrating: model.productrating,
      productratag: model.productratag,
      productDescription: model.productDescription,
      productreviews: model.productreviews,
      producttime: model.producttime,
      productsimagedetails: model.productsimagedetails,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productimage': productimage,
      'productquantity': productquantity,
      'productprice': productprice ?? 0,
      'productdiscountPrice': productdiscountPrice ?? 0,
      'productsaveAmount': productsaveAmount ?? 0,
      'productrating': productrating ?? 0,
      'productratag': productratag ?? 0,
      'productDescription': productDescription ?? '',
      'productreviews': productreviews ?? '',
      'producttime': producttime ?? '',
      'productsimagedetails': productsimagedetails ?? [],
    };
  }
}
