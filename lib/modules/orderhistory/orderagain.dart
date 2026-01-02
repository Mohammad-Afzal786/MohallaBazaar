import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/presentation/widgets/searchbarwidget.dart';
import '../../presentation/widgets/bottomfootercard.dart';

/// 🔹 Category Page
/// Responsive UI with ScreenUtil + Clean Code
class Orderagain extends StatefulWidget {
  const Orderagain({super.key});

  @override
  State<Orderagain> createState() => _OrderagainState();
}

class _OrderagainState extends State<Orderagain> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> fakeOrderHistory = [
    {
      "orderId": "O-000123",
      "status": "Delivered",
      "grandTotal": 250,
      "date": "2025-09-25",
    },
    {
      "orderId": "O-000124",
      "status": "Placed",
      "grandTotal": 120,
      "date": "2025-09-27",
    }
  ];

  

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

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());

    /// 🔹 Responsive calculation for 3-column grid
    final screenWidth = MediaQuery.of(context).size.width;
    final itemHeight = 350.h;
    final totalHorizontalPadding = 20.w;
    final crossAxisSpacing = 8.w;
    final itemWidth =
        (screenWidth - totalHorizontalPadding - (2 * crossAxisSpacing)) / 3;
    final childAspectRatio = itemWidth / itemHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// 🔹 Status bar padding
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppsColors.primary,
          ),

          /// 🔹 Main Scrollable Content
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                /// Header
                SliverToBoxAdapter(
                  child: Container(
                    color: AppsColors.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Back Button
                        GestureDetector(
                          onTap: () => controller.changeTab(0),
                          child: Container(
                            width: 35.w,
                            height: 35.w,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
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

                        /// Title
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 27.sp,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: "mohalla ",
                                      style: TextStyle(fontFamily: 'Geometry'),
                                    ),
                                    TextSpan(
                                      text: "bazaar",
                                      style: TextStyle(
                                        fontFamily: 'Geometry',
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Delivery in 30 minutes",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 🔹 Sticky Search Bar
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickySearchBarDelegate(
                    height: 65.h,
                    child: Container(
                      color: AppsColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      child: SearchBarWidget(),
                    ),
                  ),
                ),

                /// 🔹 Order History
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (fakeOrderHistory.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                          child: Text(
                            "Your Orders",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      for (var order in fakeOrderHistory)
                         _OrderHistoryCard(
                           orderId: order["orderId"],
                           status: order["status"],
                           date: order["date"],
                           total: order["grandTotal"],
                         ),
                    ],
                  ),
                ),

                /// 🔹 Section Title
                SliverToBoxAdapter(child: _SectionTitle("Best Sellers")),

                

                /// 🔹 Promo Banner
                SliverToBoxAdapter(
                  child: const PromoBottomCard(
                    message: "Har zaroorat,\nBas kuch minute mein\ndelivered ❤️",
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 30.h)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// 🔹 Sticky Search Bar Delegate
/// ---------------------------------------------------------------------------
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

/// ---------------------------------------------------------------------------
/// 🔹 Section Title
/// ---------------------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// 🔹 Bestseller Card
/// ---------------------------------------------------------------------------

/// ---------------------------------------------------------------------------
/// 🔹 Order History Card (with buttons)
/// ---------------------------------------------------------------------------
class _OrderHistoryCard extends StatelessWidget {
  final String orderId;
  final String status;
  final String date;
  final num total;

  const _OrderHistoryCard({
    required this.orderId,
    required this.status,
    required this.date,
    required this.total,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order #$orderId",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2.h),
                  Text(date, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
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
                        color: status == "Delivered" ? Colors.green : Colors.orange),
                  ),
                  SizedBox(height: 2.h),
                  Text("₹$total",
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
         
          SizedBox(height: 12.h),
        Row(
  children: [
    Expanded(
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppsColors.primary),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          minimumSize: Size.fromHeight(40.h), // same height
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        ),
        child: Text(
          "View Order",
          style: TextStyle(fontSize: 12.sp, color: AppsColors.primary),
        ),
      ),
    ),
    SizedBox(width: 10.w),
    Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppsColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          minimumSize: Size.fromHeight(40.h), // same height
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
        ),
        child: Text(
          "Track Order",
          style: TextStyle(fontSize: 12.sp, color: Colors.white),
        ),
      ),
    ),
  ],
)

        
       
        ],
      ),
    );
  }
}
