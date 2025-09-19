import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/modules/home/home.dart';
import 'package:mohalla_bazaar/modules/category/presentation/pages/category.dart';
import 'package:mohalla_bazaar/modules/cart/cart.dart';
import 'package:mohalla_bazaar/modules/orderagain/orderagain.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardController controller = Get.put(DashboardController());

  Future<bool> _onWillPop(BuildContext context) async {
    if (controller.tabIndex.value != 0) {
      controller.changeTab(0);
      return false;
    } else {
      final shouldExit = await showCupertinoDialog<bool>(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text("Exit App",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content: const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text("Are you sure you want to exit the app?"),
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    SystemNavigator.pop();
                  },
                  child: const Text("Exit"),
                ),
              ],
            ),
          ) ??
          false;

      return shouldExit;
    }
  }

  @override
  void initState() {
    super.initState();
    /// Set status bar theme
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const Orderagain();
      case 2:
        return CategoriesPage(); // ✅ Har bar naya instance
      case 3:
        return const Cart();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Obx(
        () => Scaffold(
          body: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is UserScrollNotification) {
                final direction = scrollNotification.direction;
                if (direction == ScrollDirection.forward) {
                  controller.showBottomNav();
                } else if (direction == ScrollDirection.reverse) {
                  controller.hideBottomNav();
                }
              }
              return false;
            },
            child: _buildPage(controller.tabIndex.value),
          ),
          bottomNavigationBar: Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: -1.0,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: controller.isBottomNavVisible.value
                  ? Theme(
                      key: const ValueKey("BottomNav"),
                      data: Theme.of(context).copyWith(
                        splashFactory: NoSplash.splashFactory,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                      child: BottomNavigationBar(
                        backgroundColor: Colors.white,
                        type: BottomNavigationBarType.fixed,
                        currentIndex: controller.tabIndex.value,
                        onTap: controller.changeTab,
                        selectedItemColor: AppsColors.primary,
                        unselectedItemColor: Colors.black54,
                        items: [
                          _buildNavItem(
                              icon: Icons.home_outlined,
                              activeIcon: Icons.home,
                              label: "Home",
                              index: 0),
                          _buildNavItem(
                              icon: Icons.shopping_bag_outlined,
                              activeIcon: Icons.shopping_bag,
                              label: "Order Again",
                              index: 1),
                          _buildNavItem(
                              icon: Icons.grid_view,
                              activeIcon: Icons.grid_view_outlined,
                              label: "Category",
                              index: 2),
                          _buildNavItem(
                              icon: Icons.add_shopping_cart_outlined,
                              activeIcon: Icons.shopping_cart,
                              label: "Cart",
                              index: 3),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey("Empty")),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    bool isActive = controller.tabIndex.value == index;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3,
            width: 60,
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: isActive ? AppsColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Icon(isActive ? activeIcon : icon,
              color: isActive ? AppsColors.primary : Colors.black54, size: 24),
        ],
      ),
      label: label,
    );
  }
}
