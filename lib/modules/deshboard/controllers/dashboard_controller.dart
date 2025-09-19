import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_bloc.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_event.dart';
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
