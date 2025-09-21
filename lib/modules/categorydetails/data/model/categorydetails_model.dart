// Path: lib/features/categories/data/models/categorydetails_model.dart

import 'package:mohalla_bazaar/modules/categorydetails/data/model/categorydetails_response.dart';
import 'package:mohalla_bazaar/modules/categorydetails/domain/entities/categorydetails_entity.dart';

extension CategoryDetailsResponseMapper on CategoryDetailsResponse {
  List<CategoryDetailsEntity> toEntities() {
    return data.map((d) => d.toEntity()).toList();
  }
}

extension CategoryDetailsDataMapper on CategoryDetailsData {
  CategoryDetailsEntity toEntity() {
    return CategoryDetailsEntity(
      categoryId: categoryId,
      categoryName: categoryName,
      image: image,
      subcategories: subcategories.map((s) => s.toEntity()).toList(),
    );
  }
}

extension SubCategoryDetailsMapper on SubCategoryDetails {
  SubCategoryEntity toEntity() {
    return SubCategoryEntity(
      id: id,
      name: name,
      image: image,
      products: products.map((p) => p.toEntity()).toList(),
    );
  }
}

extension ProductDetailsMapper on ProductDetails {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      image: image,
      productName: productName,
      quantity: quantity,
      price: price,
      discountPrice: discountPrice,
      saveAmount: saveAmount,
      rating: rating,
      reviews: reviews,
      time: time,
    );
  }
}
