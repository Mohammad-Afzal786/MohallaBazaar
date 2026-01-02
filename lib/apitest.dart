// import 'package:dio/dio.dart';

// final Dio dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:3000/api/")); // Emulator IP

// Future<void> addToCart() async {
//   try {
//     final cartData = {
//       "userId": "6510c3e8f12a4d35b92b1234",
//       "productId": "P-0001",
//     };

//     final response = await dio.post(
//       '/addtocart',
//       data: cartData,
//     );

//     print("✅ Added to cart successfully: ${response.data}");
//   } catch (e) {
//     print("❌ API failed: $e");
//   }
// }
