// Local data source - SQLite cache handle karega
import 'dart:convert';
import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import '../models/orderhistory_response.dart';

abstract class OrderHistoryLocalDataSource {
  Future<OrderHistoryResponse?> getCachedOrderHistory(String userId);
  Future<void> cacheOrderHistory(String userId, OrderHistoryResponse response);
  Future<void> removeCachedOrderHistory(String userId); // cache delete method
}

class OrderHistoryLocalDataSourceImpl implements OrderHistoryLocalDataSource {
  @override
  Future<OrderHistoryResponse?> getCachedOrderHistory(String userId) async {
    try {
      final map = await SQLiteClient.getOrderHistory(userId);
      print("✅ Fetching local cache for userId=$userId: $map"); // debug

      if (map == null) return null;

      final jsonString = map['jsonResponse'] as String?;
      if (jsonString == null) return null;

      final decoded = jsonDecode(jsonString);
      return OrderHistoryResponse.fromJson(decoded);
    } catch (e) {
      print("❌ Failed to load cached OrderHistory for userId=$userId: $e");
      return null;
    }
  }

  @override
  Future<void> cacheOrderHistory(String userId, OrderHistoryResponse response) async {
    try {
      final jsonString = jsonEncode(response.toJson());
      await SQLiteClient.saveOrderHistory(userId, jsonString);
      print("✅ Cached OrderHistory saved for userId=$userId");
    } catch (e) {
      print("❌ Failed to cache OrderHistory for userId=$userId: $e");
    }
  }

 
  @override
Future<void> removeCachedOrderHistory(String userId) async {
  try {
    await SQLiteClient.removeOrderHistory(userId);
  } catch (e) {
    print("❌ Failed to remove cached OrderHistory: $e");
  }
}

}
