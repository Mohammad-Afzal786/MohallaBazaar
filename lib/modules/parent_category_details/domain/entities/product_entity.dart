// Path: lib/features/parent_categorydetails/domain/entities/product_entity.dart
class ProductEntity {
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
 final List<String>? productsimagedetails; // ✅ new fiel

  

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
    required this.productsimagedetails, // new field
 
  });

   Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'productimage': productimage,
        'productquantity': productquantity,
        'productprice': productprice,
        'productsimagedetails': productsimagedetails, // ✅ add to JSON
        'productdiscountPrice': productdiscountPrice,
        'productsaveAmount': productsaveAmount,
        'productrating': productrating,
        'productratag': productratag,
        'productDescription': productDescription,
        'productreviews': productreviews,
        'producttime': producttime,
      
        
      
      };

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productimage: json['productimage'] ?? '',
      productquantity: json['productquantity'] ?? '',
      productprice: (json['productprice'] as num?)?.toInt() ?? 0,
      productdiscountPrice: (json['productdiscountPrice'] as num?)?.toInt() ?? 0,
      productsaveAmount: (json['productsaveAmount'] as num?)?.toInt() ?? 0,
      productrating: (json['productrating'] as num?)?.toDouble() ?? 0.0,
      productratag: (json['productratag'] as num?)?.toInt() ?? 0,
      productDescription: json['productDescription'] ?? '',
      productreviews: json['productreviews'] ?? '',
      producttime: json['producttime'] ?? '',
      productsimagedetails: (json['productsimagedetails'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(), // ✅ nullable, no ?? []
      
    );

}
