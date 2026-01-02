import 'package:mohalla_bazaar/modules/cart/data/models/cart_count_model.dart';
import 'package:mohalla_bazaar/modules/cart/data/models/cart_item_model.dart';
import 'package:mohalla_bazaar/modules/cart/data/models/cart_response_model.dart';
import 'package:mohalla_bazaar/core/network/api_client.dart';

class CartRemoteDataSource {
  final ApiClient apiClient;

  CartRemoteDataSource(this.apiClient);

  /// Adds an item to the cart and returns the full API response
  Future<CartResponseModel> addToCart(CartItemModel cartItemModel) async {
    try {
      final response = await apiClient.addToCart(cartItemModel);
      // Retrofit already returns CartResponseModel, no parsing needed
      return response;
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

Future<CartCountModel> fetchCartCount(String userId) async {
  try {
    final response = await apiClient.fetchCartCount(userId);
    return response; // Retrofit already returns CartCountModel
  } catch (e) {
    throw Exception('Failed to fetch cart count: $e');
  }
}


  
}
