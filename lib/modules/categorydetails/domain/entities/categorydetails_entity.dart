// Path: lib/features/categories/domain/entities/categorydetails_entity.dart
class ProductEntity {
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

  ProductEntity({
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
  @override
  String toString() {
    return 'ProductEntity(id: $id, name: $productName, price: $discountPrice, image: $image)';
  }
}

class SubCategoryEntity {
  final String id;
  final String name;
  final String image;
  final List<ProductEntity> products;

  SubCategoryEntity({required this.id, required this.name, required this.image, required this.products});
}

class CategoryDetailsEntity {
  final String categoryId;
  final String categoryName;
  final String image;
  final List<SubCategoryEntity> subcategories;

  CategoryDetailsEntity({
    required this.categoryId,
    required this.categoryName,
    required this.image,
    required this.subcategories,
  });
}
