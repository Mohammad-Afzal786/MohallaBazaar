// Path: lib/features/cart/data/datasources/cart_item_local_data_source.dart

import 'package:mohalla_bazaar/core/network/sqlite_client.dart';

/// 🔹 Model: Cart Count
class CartCountModel {
  int count;

  CartCountModel({required this.count});

  // Map के रूप में convert करना (SQLite insert/update के लिए)
  Map<String, dynamic> toMap() {
    return {
      'count': count,
    };
  }

  // SQLite से map → object
  factory CartCountModel.fromMap(Map<String, dynamic> map) {
    return CartCountModel(
      count: map['count'] as int,
    );
  }
}

/// 🔹 Local DataSource
class CartLocalDataSource {
  /// Cache cart count
  Future<void> cacheCartCount(CartCountModel model) async {
    await SQLiteClient.saveCartCount(model.count);
  }

  /// Get cached cart count
  Future<CartCountModel?> getCachedCartCount() async {
    final count = await SQLiteClient.getCartCount();
    return CartCountModel(count: count);
  }
}
