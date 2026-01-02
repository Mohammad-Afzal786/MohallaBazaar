import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/core/errors/exceptions.dart';
import 'package:mohalla_bazaar/core/network/api_client.dart';

// Models
import 'package:mohalla_bazaar/modules/authentication_app/data/models/login_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/login_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/register_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/register_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/forgatepass_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/forgetpass_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/resetpassword_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/resetpassword_response.dart';

/// =============================================================
/// 🔹 Remote DataSource Contract
/// =============================================================
abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(String email, String password,String fcmtoken);

  Future<RegisterResponse> register(
    String name,
    String password,
    String phone,
    String fcmtoken,
  );

  Future<ForgotPassResponse> forgotPass(String email);

  /// Reset password API call
  Future<ResetPasswordResponse> resetPassword(
    String userId,
    String newPassword,
    String confirmPassword,
  );
}

/// =============================================================
/// 🔹 Implementation
/// =============================================================
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient api;
  AuthRemoteDataSourceImpl(this.api);

  /// ---------------- LOGIN ----------------
  @override
  Future<LoginResponse> login(String phone, String password,String fcmtoken) async {
    try {
      final req = LoginRequest(phone: phone, password: password,fcmtoken: fcmtoken);
      return await api.login(req);
    } on DioException catch (e) {
      final msg = e.response?.data?['message']?.toString() ?? e.message ?? '';
      throw ServerException(msg, statusCode: e.response?.statusCode);
    }
  }

  /// ---------------- REGISTER ----------------
  @override
  Future<RegisterResponse> register(
    String name,
    String password,
    String phone,
    String fcmtoken
  ) async {
    try {
      final req = RegisterRequest(
        name: name,
        password: password,
        phone: phone,
        fcmtoken:fcmtoken
      );
      return await api.register(req);
    } on DioException catch (e) {
      final msg = e.response?.data?['message']?.toString() ?? e.message ?? '';
      throw ServerException(msg, statusCode: e.response?.statusCode);
    }
  }

  /// ---------------- FORGOT PASSWORD ----------------
  @override
  Future<ForgotPassResponse> forgotPass(String phone) async {
    try {
      final req = ForgotPassRequest(phone: phone);
      return await api.forgotPass(req);
    } on DioException catch (e) {
      final msg =
          e.response?.data?['error']?.toString() ??
          e.response?.data?['message']?.toString() ??
          e.message ??
          '';
      throw ServerException(msg, statusCode: e.response?.statusCode);
    }
  }

  /// ---------------- Reset PASSWORD ----------------
  @override
  Future<ResetPasswordResponse> resetPassword(
    String userId,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      final req = ResetPasswordRequest(
        userId: userId,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return await api.resetpassword(req );
    } on DioException catch (e) {
      // ServerException throw करें error handling के लिए
      final msg =
          e.response?.data?['data']?['message']?.toString() ?? e.message ?? '';
      throw ServerException(msg, statusCode: e.response?.statusCode);
    }
  }
}
