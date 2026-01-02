import 'package:dio/dio.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/forgatepass_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/forgetpass_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/login_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/login_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/register_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/register_response.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/resetpassword_request.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/resetpassword_response.dart';
import 'package:mohalla_bazaar/modules/banner/data/models/banner_response.dart';
import 'package:mohalla_bazaar/modules/cart/data/models/cart_count_model.dart';
import 'package:mohalla_bazaar/modules/cart/data/models/cart_item_model.dart';
import 'package:mohalla_bazaar/modules/cart/data/models/cart_response_model.dart';
import 'package:mohalla_bazaar/modules/cart/data/models/viewcart_response.dart';
import 'package:mohalla_bazaar/modules/category/data/model/category_response.dart';
import 'package:mohalla_bazaar/modules/category_details/data/models/category_details_response.dart';
import 'package:mohalla_bazaar/modules/home_category_products/data/models/home_category_products_response.dart';
import 'package:mohalla_bazaar/modules/notification/data/models/notification_response.dart';
import 'package:mohalla_bazaar/modules/order_now/data/model/order_model.dart';
import 'package:mohalla_bazaar/modules/order_now/data/model/order_request.dart';
import 'package:mohalla_bazaar/modules/orderhistory/data/models/orderhistory_response.dart'
    show OrderHistoryResponse;
import 'package:mohalla_bazaar/modules/parent_category/data/models/parent_category_response.dart';
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
  Future<ResetPasswordResponse> resetpassword(
    @Body() ResetPasswordRequest request,
  );

  @GET("/categories")
  @Extra({"requiresToken": false})
  Future<CategoryResponse> getCategories();

  /// GET /getproducts?parentCategoryId=PC-0001
  @GET("/getproducts")
  @Extra({"requiresToken": false})
  Future<ParentCategoryDetailsResponse> getParentCategoryDetails(
    @Query("parentCategoryId") String parentCategoryId,
  );

  @GET("/getCategoryProducts")
  @Extra({"requiresToken": false})
  Future<CategoryDetailsResponse> getCategoryDetails(
    @Query("categoryId") String CategoryId,
  );

  @POST("/addtocart")
  @Extra({"requiresToken": false})
  Future<CartResponseModel> addToCart(@Body() CartItemModel request);

  @GET("/CartCount")
  @Extra({"requiresToken": false})
  Future<CartCountModel> fetchCartCount(@Query("userId") String userId);

  // ViewCart
  @GET("/viewcart")
  @Extra({"requiresToken": false})
  Future<ViewCartResponse> getViewCart(@Query("userId") String userId);

  @POST("/orderNow")
  @Extra({"requiresToken": false})
  Future<OrderModel> placeOrder(@Body() OrderRequest request);

  /// 🔹 Get Order History
  @GET("/orderhistory")
  @Extra({"requiresToken": false}) // अगर login user specific है तो true रखो
  Future<OrderHistoryResponse> getOrderHistory(@Query("userId") String userId);

  @GET("/get-notifications")
  @Extra({"requiresToken": false})
  Future<NotificationResponse> getNotifications(@Query("userId") String userId);
  @GET("/homeCategoryProducts")
  @Extra({"requiresToken": false})
  Future<HomeCategoryProductsResponse> getHomeCategoryProducts();

  @GET("getbanner")
  @Extra({"requiresToken": false})
  Future<BannerResponse> getBanners();

  // Adjust path to your backend. You mentioned GET /api/get_parent-category earlier — match that.
  @GET("get_parent-category")
  @Extra({"requiresToken": false})
  Future<ParentCategoryResponse> getParentCategories();


}
