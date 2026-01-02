import 'package:mohalla_bazaar/core/network/sqlite_client.dart';

import '../../domain/entities/orderhistory_entity.dart';
import '../../domain/repositories/orderhistory_repository.dart';
import '../datasources/orderhistory_local_data_source.dart';
import '../datasources/orderhistory_remote_data_source.dart';
import '../models/orderhistory_response.dart';

class OrderHistoryRepositoryImpl implements OrderHistoryRepository {
  final OrderHistoryRemoteDataSource remote;
  final OrderHistoryLocalDataSource local;

  OrderHistoryRepositoryImpl({required this.remote, required this.local});

  /// 🔹 Sirf LOCAL cache se data (null agar empty hai)
  @override
  Future<OrderHistoryEntity?> getCachedOrderHistory(String userId) async {
    final cached = await local.getCachedOrderHistory(userId);
    if (cached != null && cached.data.isNotEmpty) {
      return _mapResponseToEntity(cached);
    }
    return null;
  }

  /// 🔹 Sirf REMOTE se data + cache update
 @override
Future<OrderHistoryEntity> getRemoteOrderHistory(String userId) async {
  try {
    final fresh = await remote.fetchOrderHistory(userId);

    // Agar server error ya empty data bheje
    if (fresh.status.toLowerCase() == "error" || fresh.data.isEmpty) {
      await local.removeCachedOrderHistory(userId);
      return OrderHistoryEntity(
        status: fresh.status,
        message: fresh.message,
        orders: [],
      );
    }

    // Success → cache update
    await local.cacheOrderHistory(userId, fresh);
    return _mapResponseToEntity(fresh);
  } catch (e) {
    print("❌ Remote fetch failed: $e");

    // Agar remote fail hua → purani cache delete karo
    await local.removeCachedOrderHistory(userId);
    final cacheAfterDelete = await SQLiteClient.getOrderHistory(userId);
    print("Cache after delete due to remote failure: $cacheAfterDelete");

    // Return empty entity
    return OrderHistoryEntity(
      status: "error",
      message: "No orders found",
      orders: [],
    );
  }
}


  /// 🔹 Response → Entity mapper
  OrderHistoryEntity _mapResponseToEntity(OrderHistoryResponse response) {
    return OrderHistoryEntity(
      status: response.status,
      message: response.message,
      orders: response.data.map((o) {
        return OrderEntity(
          orderId: o.orderId,
          status: o.status,
           currentStep: o.currentStep,
          grandTotal: o.grandTotal.toInt(),
          estimatedDelivery: o.estimatedDelivery,
          createdAt: DateTime.tryParse(o.createdAt) ?? DateTime.now(),
          cartItemCount: o.cartItemCount.toInt(),
          totalCartProductsAmount: o.totalCartProductsAmount.toInt(),
          totalCartDiscountAmount: o.totalCartDiscountAmount.toInt(),
          totalSaveAmount: o.totalSaveAmount.toInt(),
          handlingCharge: o.handlingCharge.toInt(),
          deliveryCharge: o.deliveryCharge.toInt(),
          items: o.items.map((i) {
            return OrderItemEntity(
              productId: i.productId,
              productName: i.productName,
              quantity: i.quantity.toInt(),
              price: i.price.toInt(),
              discountPrice: i.discountPrice.toInt(),
              productImage: i.productimage,
              productquantity: i.productquantity,
              totalProductPrice: i.totalProductPrice.toInt(),
              totalDiscountPrice: i.totalDiscountPrice.toInt(),
              productSaveAmount: i.productsaveAmount.toInt(),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
