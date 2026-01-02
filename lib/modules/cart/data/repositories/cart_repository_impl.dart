import 'package:mohalla_bazaar/modules/cart/data/datasources/cart_item_local_data_source.dart';
import 'package:mohalla_bazaar/modules/cart/domain/entities/cart_item_entity.dart';
import '../../domain/entities/cart_count_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_data_source.dart';
import '../models/cart_item_model.dart';
import '../models/cart_response_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remote;
  final CartLocalDataSource local;

  CartRepositoryImpl({required this.remote, required this.local});

  @override
  Future<int> addToCart(CartItemEntity cartItem) async {
    final CartResponseModel response = await remote.addToCart(
      CartItemModel(
        userId: cartItem.userId,
        productId: cartItem.productId,
        action: cartItem.action,
        
      ),
    );

    return response.totalCartItem;
  }

  @override
  Future<CartCountEntity> getCartCount(String userId) async {
    try {
      // Remote fetch
      final CartCountEntity remoteData = await remote.fetchCartCount(userId);

      // SQLite में save (convert to model)
      final model = CartCountModel(count: remoteData.count);
      await local.cacheCartCount(model);

      return remoteData;
    } catch (e) {
      // Agar remote fail → cache se fetch
      final cachedModel = await local.getCachedCartCount();
      if (cachedModel != null) {
        return CartCountEntity(count: cachedModel.count);
      }
      rethrow;
    }
  }
}
