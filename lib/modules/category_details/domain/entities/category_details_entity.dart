/// 🔹 Product Entity for CategoryDetails
class ProductEntity {
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

  ProductEntity({
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

   Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'productimage': productimage,
        'productquantity': productquantity,
        'productprice': productprice,
        'productdiscountPrice': productdiscountPrice,
        'productsaveAmount': productsaveAmount,
        'productrating': productrating,
        'productratag': productratag,
        'productDescription': productDescription,
        'productreviews': productreviews,
        'producttime': producttime,
      };

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
        productId: json['productId'],
        productName: json['productName'],
        productimage: json['productimage'],
        productquantity: json['productquantity'],
        productprice: json['productprice'],
        productdiscountPrice: json['productdiscountPrice'],
        productsaveAmount: json['productsaveAmount'],
        productrating: json['productrating'],
        productratag: json['productratag'],
        productDescription: json['productDescription'],
        productreviews: json['productreviews'],
        producttime: json['producttime'],
      );
}
