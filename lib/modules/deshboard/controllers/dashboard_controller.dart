import 'package:get/get.dart';
class DashboardController extends GetxController {
  var tabIndex = 0.obs;
  var isBottomNavVisible = true.obs;

  void changeTab(int index) {
    tabIndex.value = index;
    
  }

  void hideBottomNav() => isBottomNavVisible.value = false;
  void showBottomNav() => isBottomNavVisible.value = true;

  @override
  void onReady() {
    super.onReady();
    final args = Get.arguments;
    if (args != null && args.containsKey("tab")) {
      final int tabIndex = args["tab"];
      changeTab(tabIndex);
    }
  }
}
