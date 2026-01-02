class CartResponseModel {
  final int totalCartItem;

  CartResponseModel({
    required this.totalCartItem,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    // debug print
    print("API Response JSON: $json");
    
    return CartResponseModel(
      totalCartItem: json['totalCartItem'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'totalCartItem': totalCartItem,
      };
}
