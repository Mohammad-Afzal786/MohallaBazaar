import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/modules/deshboard/slider.dart';

/// 🔹 Notification Model
class NotificationModel {
  final IconData icon;
  final Color iconBg;
  final String type;
  final String time;
  final String title;
  final String subtitle;

  NotificationModel({
    required this.icon,
    required this.iconBg,
    required this.type,
    required this.time,
    required this.title,
    required this.subtitle,
  });
}

/// 🔹 Notification Page
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();

    final List<NotificationModel> notifications = [
      NotificationModel(
        icon: Icons.local_offer,
        iconBg: Colors.pink.shade100,
        type: "Offers",
        time: "Just now",
        title:
            "Big Savings Alert! 🎉 Get flat 20% OFF on your first grocery order today.",
        subtitle: "Shop Now",
      ),
      NotificationModel(
        icon: Icons.shopping_cart,
        iconBg: Colors.blue.shade100,
        type: "Order Update",
        time: "2 hrs",
        title: "Your order #12345 is packed and ready to be shipped 🚚",
        subtitle: "Track Order",
      ),
      NotificationModel(
        icon: Icons.star,
        iconBg: Colors.orange.shade100,
        type: "Recommendations",
        time: "1 day",
        title: "Top picks for you: Fresh fruits & snacks at best prices 🍎🥨",
        subtitle: "View Items",
      ),
      NotificationModel(
        icon: Icons.card_giftcard,
        iconBg: Colors.green.shade100,
        type: "Rewards",
        time: "3 days",
        title: "You just earned 50 reward points on your last purchase 🎁",
        subtitle: "Redeem Now",
      ),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) NavHelper.backTonotification();
      },
      child: Scaffold(
        body: 
        Column(
          children: [
            /// 🔹 Status bar padding
            Container(
              height: MediaQuery.of(context).padding.top,
              color: AppsColors.primary,
            ),

            /// 🔹 Main Content
            Expanded(
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  /// Header
                  SliverToBoxAdapter(
                    child: 
                    Container(
                      color: AppsColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
                          /// Back Button
                          GestureDetector(
                            onTap: () => NavHelper.backTonotification(),
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

                          /// App name
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
                                        style: TextStyle(
                                          fontFamily: 'Geometry',
                                        ),
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

                  /// Sticky Slider
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: CustomSliderPageView(),
                    ),
                  ),

                  /// Notifications List / Empty State
                  SliverToBoxAdapter(
                    child: notifications.isEmpty
                        ? _EmptyNotificationView()
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(12.w),
                            itemCount: notifications.length,
                            separatorBuilder: (_, __) => Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                              height: 24.h,
                            ),
                            itemBuilder: (context, index) {
                              final notif = notifications[index];
                              return _NotificationTile(notif: notif);
                            },
                          ),
                  ),

                  /// Promo Card
                  SliverToBoxAdapter(
                    child: PromoBottomCard(
                      message:
                          "Har zaroorat,\nBas kuch minute mein\ndelivered",
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 30.h)),
                ],
              ),
            ),
         
          ],
        ),
      ),
    );
  }
}

/// 🔹 Sticky Header Delegate
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
  bool shouldRebuild(covariant _StickySearchBarDelegate oldDelegate) =>
      oldDelegate.child != child || oldDelegate.height != height;
}

/// 🔹 Single Notification Tile
class _NotificationTile extends StatelessWidget {
  final NotificationModel notif;
  const _NotificationTile({required this.notif});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Icon circle
        Container(
          decoration: BoxDecoration(
            color: notif.iconBg,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(6.w),
          child: Icon(notif.icon, color: Colors.black, size: 20.sp),
        ),
        SizedBox(width: 12.w),

        /// Texts
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    notif.type,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "• ${notif.time}",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                notif.title,
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
              SizedBox(height: 4.h),
              Text(
                notif.subtitle,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
            ],
          ),
        ),

        /// Three-dot button
        IconButton(
          icon: Icon(Icons.more_vert, size: 22.sp, color: Colors.grey),
          onPressed: () => _showBottomSheet(context, notif),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, NotificationModel notif) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: notif.iconBg,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(6.w),
                  child: Icon(notif.icon, color: Colors.black87, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Text(
                  notif.type,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            /// Title + Subtitle
            Text(
              notif.title,
              style: TextStyle(fontSize: 12.sp, color: Colors.black),
            ),
            SizedBox(height: 6.h),
            Text(
              notif.subtitle,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),

            SizedBox(height: 22.h),
            Divider(color: Colors.grey.shade300),

            /// Delete option
            ListTile(
              leading: Icon(Icons.delete_outline, size: 22.sp),
              title: Text(
                "Delete this notification",
                style: TextStyle(fontSize: 13.sp),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Empty Notification View
class _EmptyNotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/bell.png',
            width: 120.w,
            height: 120.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20.h),
          Text(
            "No Notification yet",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppsColors.primary,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 32.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            onPressed: () {},
            child: Text(
              "Explore Categories",
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 Promo Card (Blinkit-style)
/// 🔹 Promo Card (Container-based clean design)
class PromoBottomCard extends StatelessWidget {
  final String message;
  const PromoBottomCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white, // 👈 simple light background
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Heading text
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                height: 1.3,
              ),
              children: [
                const TextSpan(text: "Har zaroorat,\n"),
                const TextSpan(text: "Bas kuch minute mein\n"),
                TextSpan(
                  text: "delivered ",
                  style: TextStyle(
                    color: AppsColors.primary, // 👈 green highlight
                  ),
                ),
               
              ],
            ),
          ),
          SizedBox(height: 16.h),

          /// Footer line
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 10.sp, color: Colors.black87),
                    children: [
                      const TextSpan(
                        text: "Thank you for your trust — with love, ",
                      ),
                      TextSpan(
                        text: "Mohalla Bazaar Team",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppsColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}
