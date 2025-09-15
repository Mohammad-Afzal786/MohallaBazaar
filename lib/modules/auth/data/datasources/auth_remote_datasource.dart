import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/core/errors/exceptions.dart';

import 'package:retrofit/retrofit.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
part 'auth_remote_datasource.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('login')
  Future<LoginResponse> login(@Body() LoginRequest body);
}

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService api;
  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<LoginResponse> login(String email, String password) async {
    try {
      final req = LoginRequest(email: email, password: password);
      return await api.login(req);
    } on DioException catch (e) {
      final msg = e.response?.data?['message']?.toString() ?? e.message ?? '';
      throw ServerException(msg, statusCode: e.response?.statusCode);
    }
  }
}
