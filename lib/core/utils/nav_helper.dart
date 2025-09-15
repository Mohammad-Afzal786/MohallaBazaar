import 'package:get/get.dart';
import 'package:mohalla_bazaar/config/routes.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';

class NavHelper {
  // /// ======================
  /// 🚀 Auth Pages
  /// ======================
  static void goToLogin() {
    if (Get.currentRoute != AppRoutes.login) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  static void goToproducsdetails() {
    if (Get.currentRoute != AppRoutes.productsdetails) {
      Get.toNamed(AppRoutes.productsdetails);
    }
  }

  static void backToprducsdetails() {
    if (Get.currentRoute == AppRoutes.productsdetails) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      Future.delayed(const Duration(milliseconds: 100), () {
        final controller = Get.find<DashboardController>();
        controller.changeTab(0);
      });
    }
  }

  static void goTocategorydetails() {
    if (Get.currentRoute != AppRoutes.categorydetails) {
      Get.toNamed(AppRoutes.categorydetails);
    }
  }

  static void backTocategorydetails() {
    if (Get.currentRoute == AppRoutes.categorydetails) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      Future.delayed(const Duration(milliseconds: 100), () {
        final controller = Get.find<DashboardController>();
        controller.changeTab(0);
      });
    }
  }

  static void backToLogin() {
    if (Get.previousRoute == AppRoutes.login) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  // /// ======================
  /// 🚀 Auth Pages
  /// ======================
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

  /// ======================
  /// 🚀 Forgot Password
  /// ======================
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
  /// 🚀 Edit Profile
  /// ======================
  static void goToEditProfile() {
    if (Get.currentRoute != AppRoutes.editProfile) {
      Get.toNamed(AppRoutes.editProfile);
    }
  }

  static void backToProfileFromEdit() {
    if (Get.currentRoute == AppRoutes.editProfile) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(4);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      Future.delayed(const Duration(milliseconds: 100), () {
        final controller = Get.find<DashboardController>();
        controller.changeTab(4);
      });
    }
  }

  /// ======================
  /// 🚀 Profile
  /// ======================
  static void goToProfile() {
    if (Get.currentRoute != AppRoutes.profile) {
      Get.toNamed(AppRoutes.profile);
    }
  }

  static void backToProfile() {
    if (Get.currentRoute == AppRoutes.profile) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      Future.delayed(const Duration(milliseconds: 100), () {
        final controller = Get.find<DashboardController>();
        controller.changeTab(0);
      });
    }
  }

  /// ======================
  /// 🚀 coinwallet
  /// ======================
  static void goTocoinwallet() {
    if (Get.currentRoute != AppRoutes.coinwallet) {
      Get.toNamed(AppRoutes.coinwallet);
    }
  }

  static void backTocoinwallet() {
    if (Get.currentRoute == AppRoutes.coinwallet) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      Future.delayed(const Duration(milliseconds: 100), () {
        final controller = Get.find<DashboardController>();
        controller.changeTab(0);
      });
    }
  }

  /// ======================
  /// 🚀 notificatin
  /// ======================
  static void goTonotificatin() {
    if (Get.currentRoute != AppRoutes.notification) {
      Get.toNamed(AppRoutes.notification);
    }
  }

  static void backTonotification() {
    if (Get.currentRoute == AppRoutes.notification) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      Future.delayed(const Duration(milliseconds: 100), () {
        final controller = Get.find<DashboardController>();
        controller.changeTab(0);
      });
    }
  }

  static void goTowishlist() {
    if (Get.currentRoute != AppRoutes.wishlist) {
      Get.toNamed(AppRoutes.wishlist);
    }
  }

  /// ======================
  /// 🚀 wishlist
  /// ======================
  static void goToproductsseach() {
    if (Get.currentRoute != AppRoutes.productssearch) {
      Get.toNamed(AppRoutes.productssearch);
    }
  }

  static void backFromwishlist() {
    if (Get.currentRoute == AppRoutes.wishlist) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      Future.delayed(const Duration(milliseconds: 100), () {
        final controller = Get.find<DashboardController>();
        controller.changeTab(0);
      });
    }
  }

  static void backTohomeFromwishlist() {
    if (Get.currentRoute == AppRoutes.wishlist) {
      Get.back();
      final controller = Get.find<DashboardController>();
      controller.changeTab(0);
    } else {
      Get.offAllNamed(AppRoutes.dashboard);
      Future.delayed(const Duration(milliseconds: 100), () {
        final controller = Get.find<DashboardController>();
        controller.changeTab(0);
      });
    }
  }

 static void goToCartFromProductsDetails() {
  if (Get.currentRoute != AppRoutes.productsdetails) {
    Get.toNamed(AppRoutes.dashboard)?.then((_) {
      final controller = Get.find<DashboardController>();
      controller.changeTab(3); // cart tab
    });
  } else {
    // Agar already dashboard pe hai to direct tab change
    final controller = Get.find<DashboardController>();
    controller.changeTab(3);
  }
}



  /// ======================
  /// 🚀 Create Account
  /// ======================
  static void goToCreateAccount() {
    if (Get.currentRoute != AppRoutes.createAccount) {
      Get.toNamed(AppRoutes.createAccount);
    }
  }

  static void backToCreateAccount() {
    if (Get.previousRoute == AppRoutes.createAccount) {
      Get.back();
    } else {
      Get.offAllNamed(AppRoutes.createAccount);
    }
  }

  // /// ======================
  // /// 🚀 Dashboard
  // /// ======================
  static void goToDashboard() {
    if (Get.currentRoute != AppRoutes.dashboard) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  /// 🚀 Switch Tabs Inside Dashboard
  static void goToHomeTab() => Get.find<DashboardController>().changeTab(0);
  static void goToorderagainTab() =>
      Get.find<DashboardController>().changeTab(1);
  static void goToProductsTab() => Get.find<DashboardController>().changeTab(2);
  static void goToNotificationTab() =>
      Get.find<DashboardController>().changeTab(3);
}
