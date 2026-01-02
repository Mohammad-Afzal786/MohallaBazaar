// Path: lib/features/viewcart/data/repositories/viewcart_repository_impl.dart

import 'package:mohalla_bazaar/modules/cart/data/datasources/viewcart_local_data_source.dart';
import 'package:mohalla_bazaar/modules/cart/data/datasources/viewcart_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/cart/domain/entities/viewcart_entity.dart';
import 'package:mohalla_bazaar/modules/cart/domain/repositories/viewcart_repository.dart';
import '../models/viewcart_response.dart';

class ViewCartRepositoryImpl implements ViewCartRepository {
  final ViewCartRemoteDataSource remote;
  final ViewCartLocalDataSource local;

  ViewCartRepositoryImpl({required this.remote, required this.local});

  @override
  Future<ViewCartEntity?> getCachedViewCart(String userId) async {
    final cached = await local.getCachedViewCart(userId);
    if (cached == null) return null;
    return _mapResponseToEntity(cached.data);
  }

  @override
  Future<ViewCartEntity> fetchViewCartFromApi(String userId) async {
    final response = await remote.fetchViewCart(userId);
    // Save to cache
    await local.cacheViewCart(userId, response);
    return _mapResponseToEntity(response.data);
  }

  ViewCartEntity _mapResponseToEntity(ViewCartData data) {
    final items = data.cartList.map((c) => CartItemEntity(
          id: c.id,
          parentCategoryId: c.parentCategoryId,
          categoryId: c.categoryId,
          productId: c.productId,
          productName: c.productName,
          productImage: c.productimage,
          productQuantity: c.productquantity,
          quantity: c.quantity,
          price: c.productprice,
          discountPrice: c.productdiscountPrice,
          saveAmount: c.productsaveAmount,
          productRating: (c.productrating is int)
              ? (c.productrating as int).toDouble()
              : c.productrating,
          productRatag: c.productratag,
          productDescription: c.productDescription,
          productReviews: c.productreviews,
          productTime: c.producttime,
          isActive: c.isActive,
        )).toList();

    return ViewCartEntity(
      userId: data.userId,
      cartItemCount: data.cartItemCount,
      cartTotalAmount: data.cartTotalAmount,
      grandTotal: data.grandTotal,
      totalSaveAmount: data.totalSaveAmount,
      handlingCharge: data.handlingCharge,
      deliveryCharge: data.deliveryCharge,
      needToAddForFreeDelivery: data.needToAddForFreeDelivery,
      totalCartDiscountAmount: data.totalCartDiscountAmount,
      totalCartProductsAmount: data.totalCartProductsAmount,
      cartList: items,
    );
  }

  
}
