
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tabIndex = 0.obs;
  var isBottomNavVisible = true.obs;

  void changeTab(int index) {
    tabIndex.value = index;
  }

  void hideBottomNav() => isBottomNavVisible.value = false;
  void showBottomNav() => isBottomNavVisible.value = true;
}

