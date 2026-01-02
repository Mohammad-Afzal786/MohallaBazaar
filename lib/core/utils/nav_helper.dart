import 'package:get/get.dart';
import 'package:mohalla_bazaar/config/routes.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';

import '../../modules/orderhistory/domain/entities/orderhistory_entity.dart';

class NavHelper {
  /// ======================
  /// 🚀 Auth Pages
  /// ======================
  static void goToLogin() {
    if (Get.currentRoute != AppRoutes.login) {
      Get.offAllNamed(AppRoutes.login);
    }
  }
 static void go_orderhistory_view_order(OrderEntity order) {
    if (Get.currentRoute != AppRoutes.orderhistoryvieworder) {
      Get.toNamed(AppRoutes.orderhistoryvieworder,arguments: order);
    }
  }
  static void goTochangepass(String userId) {
    if (Get.currentRoute != AppRoutes.resetpassword) {
      Get.toNamed(
        AppRoutes.resetpassword,
        arguments: {"userId": userId}, // 👈 userId पास कर दिया
      );
    }
  }

  static void backToLogin() {
    if (Get.previousRoute == AppRoutes.login) {
     Get.offAllNamed(AppRoutes.login);
    } 
  }

  static void backTochangepass() {
    if (Get.previousRoute == AppRoutes.resetpassword) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.resetpassword);
    }
  }

  
 static void goToCreateAccount() {
    if (Get.currentRoute != AppRoutes.createAccount) {
      // ✅ Use offNamed for string route
      Get.offNamed(AppRoutes.createAccount);
    }
  }



  static void backToCreateAccount() {
    if (Get.previousRoute == AppRoutes.createAccount) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.createAccount);
    }
  }

  static void goToonbording() {
    if (Get.currentRoute != AppRoutes.onbording) {
      Get.offAllNamed(AppRoutes.onbording);
    }
  }

  static void backtobording() {
    if (Get.previousRoute == AppRoutes.onbording) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.onbording);
    }
  }

  static void goToForgetPassword() {
    if (Get.currentRoute != AppRoutes.forgetPassword) {
      Get.toNamed(AppRoutes.forgetPassword);
    }
  }

  static void backToForgetPassword() {
    if (Get.previousRoute == AppRoutes.forgetPassword) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.forgetPassword);
    }
  }

  /// ======================
  /// 🚀 Dashboard & Tabs
  /// ======================
  static void goToDashboard() {
    if (Get.currentRoute != AppRoutes.dashboard) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  /// Common function for switching dashboard tabs
  static void goToDashboardTab(int tabIndex) {
    if (Get.currentRoute != AppRoutes.dashboard) {
      Get.offAllNamed(AppRoutes.dashboard, arguments: {"tab": tabIndex});
    } else {
      final controller = Get.find<DashboardController>();
      controller.changeTab(tabIndex);
    }
  }

  /// Shortcuts for specific tabs
  static void goToHomeTab() => goToDashboardTab(0);
  static void goToorderagainTab() => goToDashboardTab(1);
  static void goToCatagoryTab() => goToDashboardTab(2);
  static void goTocartTab() => goToDashboardTab(3);

  /// ======================
  /// 🚀 Other Pages
  /// ======================
  static void goToproducsdetails() {
    if (Get.currentRoute != AppRoutes.productsdetails) {
      Get.toNamed(AppRoutes.productsdetails);
    }
  }

  static void goToparentcategorydetails(String parentcategoryId) {
    if (Get.currentRoute != AppRoutes.parentcategorydetails) {
      Get.toNamed(
        AppRoutes.parentcategorydetails,
        arguments: parentcategoryId, // yahan dynamic ID
      );
    }
  }

  static void goTocategorydetails() {
    if (Get.currentRoute != AppRoutes.categorydetails) {
      Get.toNamed(AppRoutes.categorydetails);
    }
  }

  static void goTowishlist() {
    if (Get.currentRoute != AppRoutes.wishlist) {
      Get.toNamed(AppRoutes.wishlist);
    }
  }

  static void goToproductsseach() {
    if (Get.currentRoute != AppRoutes.productssearch) {
      Get.toNamed(AppRoutes.productssearch);
    }
  }

  static void goTocoinwallet() {
    if (Get.currentRoute != AppRoutes.coinwallet) {
      Get.toNamed(AppRoutes.coinwallet);
    }
  }

  static void goToordersuccessfully() {
    if (Get.currentRoute != AppRoutes.ordersuccessfully) {
      Get.toNamed(AppRoutes.ordersuccessfully);
    }
  }

  static void goTonotificatin() {
    if (Get.currentRoute != AppRoutes.notification) {
      Get.toNamed(AppRoutes.notification);
    }
  }

  static void goToProfile() {
    if (Get.currentRoute != AppRoutes.profile) {
      Get.toNamed(AppRoutes.profile);
    }
  }

  static void goToEditProfile() {
    if (Get.currentRoute != AppRoutes.editProfile) {
      Get.toNamed(AppRoutes.editProfile);
    }
  }
static void goToorderhistoryforprofile() {
    if (Get.currentRoute != AppRoutes.orderhistoryforprofile) {
      Get.toNamed(AppRoutes.orderhistoryforprofile);
    }
  }
 
  static void goToOrdertrack() {
    if (Get.currentRoute != AppRoutes.ordertrack) {
      Get.toNamed(AppRoutes.ordertrack);
    }
  }

  /// ======================
  /// 🚀 Back Navigation Helpers
  /// =================
  ///=====

  static void goToCartFromProductsDetails() {
    final controller = Get.find<DashboardController>();

    if (Get.currentRoute != AppRoutes.dashboard) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
    controller.changeTab(3); // Cart tab
  }

  static void backTohomeFromwishlist() {
    if (Get.currentRoute == AppRoutes.wishlist) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    }
  }

  static void backFromwishlist() {
    if (Get.currentRoute == AppRoutes.wishlist) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    }
  }

  static void backTonotification() {
    if (Get.currentRoute == AppRoutes.notification) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    }
  }

  static void backToOrdertrack() {

   
    if (Get.currentRoute == AppRoutes.ordertrack) {
     
      Get.offAllNamed(AppRoutes.dashboard);
     
      // ensure hota hai ki UI settle hone ke baad controller call ho
    Future.microtask(() {
      final controller = Get.find<DashboardController>();
      controller.changeTab(1);
    });
    }
  }

  static void backToordersuccessfully() {
    if (Get.currentRoute == AppRoutes.ordersuccessfully) {
      Get.offAllNamed(AppRoutes.dashboard);
      final controller = Get.find<DashboardController>();
      controller.changeTab(1);
    }
  }

  static void backTocoinwallet() {
    if (Get.currentRoute == AppRoutes.coinwallet) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    }
  }

  static void backToProfile() {
    if (Get.currentRoute == AppRoutes.profile) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    }
  }

  static void backToparentcategorydetails() {
    if (Get.currentRoute == AppRoutes.parentcategorydetails) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    }
  }

  static void backTocategorydetails() {
    if (Get.currentRoute == AppRoutes.categorydetails) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    }
  }

  static void backToprducsdetails() {
    if (Get.currentRoute == AppRoutes.productsdetails) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    }
  }
}
