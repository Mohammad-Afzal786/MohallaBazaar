/// यह helper class GetStorage को encapsulate करती है
/// ताकि हम आसानी से tokens या अन्य data save / read कर सकें
library;

import 'package:get_storage/get_storage.dart';

class StorageHelper {
  // Singleton instance
  static final StorageHelper _instance = StorageHelper._internal();
  factory StorageHelper() => _instance;
  StorageHelper._internal();

  final GetStorage _storage = GetStorage();

  /// --------------------
  /// Tokens
  /// --------------------
  // Future<void> saveAccessToken(String token) async {
  //   await _storage.write('accessToken', token);
  // }

  // String? readAccessToken() {
  //   return _storage.read('accessToken');
  // }

  // Future<void> saveRefreshToken(String token) async {
  //   await _storage.write('refreshToken', token);
  // }

  // String? readRefreshToken() {
  //   return _storage.read('refreshToken');
  // }

  // Future<void> clearTokens() async {
  //   await _storage.remove('accessToken');
  //   await _storage.remove('refreshToken');
  // }

  /// --------------------
  /// Order ID
  /// --------------------
  Future<void> saveOrderId(String orderId) async {
    await _storage.write('lastOrderId', orderId);
  }

  String? readOrderId() {
    return _storage.read('lastOrderId');
  }

  Future<void> clearOrderId() async {
    await _storage.remove('lastOrderId');
  }

  /// --------------------
  /// Generic methods
  /// --------------------
  // Future<void> saveValue(String key, dynamic value) async {
  //   await _storage.write(key, value);
  // }

  // dynamic readValue(String key) {
  //   return _storage.read(key);
  // }

  // Future<void> removeValue(String key) async {
  //   await _storage.remove(key);
  // }

  // Future<void> clearAll() async {
  //   await _storage.erase();
  // }


  // save



/// --------------------
  /// Order ID for Track Order
  /// --------------------
  Future<void> saveOrderIdForTrack(String orderId) async {
    await _storage.write('orderIdForTrackOrder', orderId);
  }

  String? readOrderIdForTrack() {
    return _storage.read('orderIdForTrackOrder');
  }

  Future<void> clearOrderIdForTrack() async {
    await _storage.remove('orderIdForTrackOrder');
  }

 
// await StorageHelper().saveOrderIdForOrderSuccess("ORD12345");
// final orderId = StorageHelper().readOrderIdForOrderSuccess();
// await StorageHelper().clearOrderIdForOrderSuccess();


}
