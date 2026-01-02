import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/constants/app_images.dart';
import 'package:mohalla_bazaar/core/storage/storage_helper.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_event.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/modules/orderhistory/domain/entities/orderhistory_entity.dart';
import 'package:mohalla_bazaar/modules/orderhistory/presentation/pages/cancelOrderByUser.dart';

import '../bloc/orderhistory_bloc.dart';
import '../bloc/orderhistory_event.dart';
import '../bloc/orderhistory_state.dart';

/// ---------------------------------------------------------------------------
/// Main Page
/// ---------------------------------------------------------------------------
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final DashboardController controller = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

//  final box = GetStorage();
    //   final userid = box.read("userid");

    //   // 🔄 Refresh the cart and count
    //   
    final box = GetStorage();
    final userId = box.read("userid");
    context.read<OrderHistoryBloc>().add(LoadOrderHistory(userId));
     context.read<ViewCartBloc>().add(LoadViewCart(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 Safe area ka top padding
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppsColors.primary,
          ),

          // 🔹 Body
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                // 🔹 Hamesha Header upar dikhna chahiye
                SliverToBoxAdapter(child: _OrderHistoryHeader(controller)),

                BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
                  builder: (context, state) {
                    // 🔹 Loading state
                    if (state.status == OrderHistoryStatus.loading) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    // 🔹 Failure state
                    if (state.status == OrderHistoryStatus.failure) {
                      return SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 18),
                            Image.asset(
                              AppImages.orderagain,
                              width: 200,
                              height: 200,
                            ),
                            Text(
                              'Reordering will be easy',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                              ),
                              child: Text(
                                'Items you order will show up here so you can buy them again easily',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // 🔹 Success state
                    if (state.status == OrderHistoryStatus.success) {
                      final orders = state.orderHistory?.orders ?? [];

                      if (orders.isEmpty) {
                        return const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              "No orders found",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      }

                      // ✅ Orders available → Header ke baad list
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final o = orders[index];
                          final formattedDate = _DateFormatter.format(
                            o.createdAt,
                          );

                          return _OrderHistoryCard(
                            orderId: o.orderId,
                            status: o.status,
                            date: formattedDate,
                            total: o.grandTotal,
                            order: o,
                          );
                        }, childCount: orders.length),
                      );
                    }

                    // 🔹 Default fallback
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          "No orders found",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Header Widget
/// ---------------------------------------------------------------------------
class _OrderHistoryHeader extends StatelessWidget {
  final DashboardController controller;
  const _OrderHistoryHeader(this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AppBar like section
        Container(
          color: AppsColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => controller.changeTab(0),
                child: Container(
                  width: 35.w,
                  height: 35.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.back,
                      size: 22.sp,
                      color: AppsColors.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 27.sp, color: Colors.white),
                        children: [
                          const TextSpan(
                            text: "mohalla ",
                            style: TextStyle(fontFamily: 'Geometry'),
                          ),
                          TextSpan(
                            text: "bazaar",
                            style: TextStyle(
                              fontFamily: 'Geometry',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Delivery in 30 minutes",
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Search bar
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// Order Card Widget
/// ---------------------------------------------------------------------------
class _OrderHistoryCard extends StatelessWidget {
  final OrderEntity order;
  final String orderId;
  final String status;
  final String date;
  final num total;

  const _OrderHistoryCard({
    required this.orderId,
    required this.status,
    required this.date,
    required this.total,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order #$orderId",
                    style: TextStyle(
                      color: AppsColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    date,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: status == "Delivered"
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    "₹$total",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    NavHelper.go_orderhistory_view_order(order);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppsColors.primary),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    minimumSize: Size.fromHeight(40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Text(
                    "View Order",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppsColors.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    final storage = StorageHelper();
                    // Save
                    await StorageHelper().saveOrderIdForTrack(orderId);

                    NavHelper.goToOrdertrack();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppsColors.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    minimumSize: Size.fromHeight(40.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Text(
                    "Track Order",
                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
                  ),
                ),
              ),

              // ❌ Cancel Button — only if currentStep == 0 or 1
              if (order.currentStep == 0 || order.currentStep == 1) ...[
                SizedBox(width: 10.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        title: "Cancel Order?",
                        middleText:
                            "Are you sure you want to cancel this order? This action cannot be undone.",
                        titleStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        middleTextStyle: TextStyle(fontSize: 13.sp),
                        backgroundColor: Colors.white,
                        radius: 12.r,
                        contentPadding: EdgeInsets.all(16.w),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Get.back(),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppsColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              "No",
                              style: TextStyle(color: AppsColors.white),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          ElevatedButton(
                            onPressed: () async {
                              final orderApi = OrderCancelApi();
                              final canceledOrder = await orderApi
                                  .cancelOrderByUser(orderId);

                              if (canceledOrder != null) {
                                Get.back();
                                final box = GetStorage();
                                final userId = box.read("userid");
                                context.read<OrderHistoryBloc>().add(
                                  LoadOrderHistory(userId),
                                );
                              } else {}
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text("Yes, Cancel"),
                          ),
                        ],
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Cancel Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Date Formatter Helper
/// ---------------------------------------------------------------------------
class _DateFormatter {
  static String format(DateTime createdAt) {
    final dt = createdAt.toLocal();

    int hour = dt.hour;
    final String ampm = hour >= 12 ? "PM" : "AM";
    hour = hour % 12;
    if (hour == 0) hour = 12;

    return "${dt.day.toString().padLeft(2, '0')}-"
        "${dt.month.toString().padLeft(2, '0')}-"
        "${dt.year} "
        "${hour.toString().padLeft(2, '0')}:"
        "${dt.minute.toString().padLeft(2, '0')} $ampm";
  }
}
// ------------------ Sticky Search Bar ------------------

class _StickySearchBarDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;
  _StickySearchBarDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(height: height, child: child);
  }

  @override
  bool shouldRebuild(covariant _StickySearchBarDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
