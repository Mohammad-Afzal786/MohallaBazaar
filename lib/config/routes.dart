import 'package:get/get.dart';
import 'package:mohalla_bazaar/core/utils/pagetransaction.dart';
import 'package:mohalla_bazaar/modules/Order_Track/Order_track.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/pages/login.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/pages/reset_password_screen.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/pages/createaccountpage.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/pages/forgetpass.dart';
import 'package:mohalla_bazaar/modules/category_details/presentation/pages/category_details_page.dart';
import 'package:mohalla_bazaar/modules/coinwallet/coinwallet.dart';
import 'package:mohalla_bazaar/modules/deshboard/deshboard.dart';
import 'package:mohalla_bazaar/modules/notification/presentation/pages/notification_page.dart';
import 'package:mohalla_bazaar/modules/order_successfully/order_successfully.dart';
import 'package:mohalla_bazaar/modules/orderhistory/presentation/pages/orderhistory_view_order.dart';
import 'package:mohalla_bazaar/modules/orderhistory/presentation/pages/orderhistoryforprofiile.dart';
import 'package:mohalla_bazaar/modules/products_search/products_search.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/pages/parent_category_details.dart';
import 'package:mohalla_bazaar/modules/profile/profile.dart';
import 'package:mohalla_bazaar/modules/wishlist/wishlist.dart';
import 'package:mohalla_bazaar/modules/onboarding/onboarding.dart';
import 'package:mohalla_bazaar/modules/products_details/products_details.dart';
import 'package:mohalla_bazaar/modules/splash/splashpage.dart';
import 'package:mohalla_bazaar/presentation/transaction/noreversetransition.dart';

import '../modules/orderhistory/domain/entities/orderhistory_entity.dart';

class AppRoutes {
  // ✅ Route names (constants)
  static const String splash = '/splash';
  static const String onbording = '/onbording';
  static const String createAccount = '/createaccount';
  static const String forgetPassword = '/forgetpassword';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String editProfile = '/editprofile';
  static const String wishlist = '/wishlist';
  static const String profile = '/profile';
  static const String coinwallet = '/coinwallet';
  static const String notification = '/notification';
  static const String parentcategorydetails = '/Parentcategorydetails';
  static const String categorydetails = '/categorydetails';
  static const String productssearch = '/productssearch';
  static const String productsdetails = '/productsdetails';
  static const String resetpassword = '/resetpassword';
  static const String ordersuccessfully = '/ordersuccessfully';
    static const String ordertrack = '/ordertrack';
    static const String orderhistoryvieworder = '/orderhistory_view_order';
    static const String orderhistoryforprofile = '/orderhistoryforprofile';
  // ✅ Route pages
  static final List<GetPage> pages = [
    GetPage(name: splash, page: () => SplashPage()),
    GetPage(name: onbording, page: () => OnboardingPage()),
    GetPage(name: createAccount, page: () => CreateAccountPage()),
    GetPage(name: forgetPassword, page: () => ForgotPasswordScreen()),
    GetPage(
      name: AppRoutes.resetpassword,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return ResetPasswordScreen(userId: args["userId"]);
      },
    ),

    GetPage(name: login, page: () => const LoginPage()),
    GetPage(
      name: dashboard,
      page: () => Dashboard(),
      customTransition: NoReverseTransition(),
    ),
     GetPage(
      name: orderhistoryvieworder,
      
      page: () {
         // Get.arguments से order object get करना
    final order = Get.arguments as OrderEntity;
    return OrderhistoryViewOrder(order: order);
      } ,
      customTransition: NoReverseTransition(),
    ),
    GetPage(
      name: orderhistoryforprofile,
      page: () => OrderHistoryforprofilePage(),
      customTransition: SlidePageTransition(SlideDirection.rightToLeft),
    ),
    GetPage(
      name: productsdetails,
      page: () => ProductsDetails(),
      customTransition: SlidePageTransition(SlideDirection.rightToLeft),
    ),
    GetPage(
      name: ordertrack,
      page: () => OrderTrack(),
      customTransition: SlidePageTransition(SlideDirection.rightToLeft),
    ),
     GetPage(
      name: ordersuccessfully,
      page: () => OrderSuccessPage(),
      customTransition: SlidePageTransition(SlideDirection.rightToLeft),
    ),
    GetPage(
      name: categorydetails,
       page: () {
        return CategoryDetailsPage();
      },
      customTransition: SlidePageTransition(SlideDirection.rightToLeft),
    ),
    GetPage(
      name: wishlist,
      page: () => WishlistPage(),
      customTransition: SlidePageTransition(SlideDirection.rightToLeft),
    ),
    GetPage(
      name: profile,
      page: () => Profile(),
      customTransition: SlidePageTransition(SlideDirection.leftToRight),
    ),
    GetPage(
      name: coinwallet,
      page: () => Coinwallet(),
      customTransition: SlidePageTransition(SlideDirection.rightToLeft),
    ),
    GetPage(
      name: notification,
      page: () => NotificationPage(),
      customTransition: SlidePageTransition(SlideDirection.rightToLeft),
    ),
    GetPage(
      name: AppRoutes.parentcategorydetails,
      page: () {
        return ParentCategoryDetailsPage();
      },
      customTransition: SlidePageTransition(SlideDirection.rightToLeft),
    ),

    GetPage(
      name: productssearch,
      page: () => ProductsSearch(),
      customTransition: SlidePageTransition(SlideDirection.rightToLeft),
    ),
  ];
}
