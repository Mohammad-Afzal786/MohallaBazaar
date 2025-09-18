import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/forgatepass_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/forgetpass_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/login_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/login_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/register_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/register_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/resetpassword_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/resetpassword_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:3000/api/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/login")
  @Extra({"requiresToken": false})
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST("/register")
  @Extra({"requiresToken": false})
  Future<RegisterResponse> register(@Body() RegisterRequest request);

  @POST("/forgotpassword")
  @Extra({"requiresToken": false})
  Future<ForgotPassResponse> forgotPass(@Body() ForgotPassRequest request);

   @POST("/resetpassword")
   @Extra({"requiresToken": false})
  Future<ResetPasswordResponse> resetpassword(@Body() ResetPasswordRequest request);
}
