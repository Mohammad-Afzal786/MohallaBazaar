import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/forgatepass_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/forgetpass_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/login_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/login_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/register_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/register_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/resetpassword_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/resetpassword_response.dart';
import 'package:mohalla_bazaar/modules/category/data/model/category_response.dart';
import 'package:mohalla_bazaar/modules/category_details/data/models/category_details_response.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/data/model/parent_categorydetails_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';
//यह Retrofit के साथ काम करने के लिए API एंडपॉइंट्स को 
//परिभाषित करता है। यह  एंडपॉइंट 
//के लिए एक नया मेथड जोड़ता है।
@RestApi(baseUrl: "http://localhost:3000/api/")
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

  @GET("/categories")
  @Extra({"requiresToken": false})
  Future<CategoryResponse> getCategories();


  /// GET /getproducts?parentCategoryId=PC-0001
  @GET("/getproducts")
  @Extra({"requiresToken": false})
  Future<ParentCategoryDetailsResponse> getParentCategoryDetails(
    @Query("parentCategoryId") String parentCategoryId,
  );

  /// GET /getproducts?parentCategoryId=PC-0001
  @GET("/getCategoryProducts")
  @Extra({"requiresToken": false})
  Future<CategoryDetailsResponse> getCategoryDetails(
    @Query("categoryId") String CategoryId,
  );
}
