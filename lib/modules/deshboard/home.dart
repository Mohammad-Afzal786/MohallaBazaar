import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/modules/deshboard/widgets/uihelper.dart';
import 'package:mohalla_bazaar/presentation/widgets/searchbarwidget.dart';

import '../../presentation/widgets/bottomfootercard.dart';

/// 🔹 Category Page
/// Responsive UI with ScreenUtil + Clean Code
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  /// 🔹 Mock Data (You can fetch from API later)
  final List<Map<String, String>> grocerykitchen = [
    {"id": "g1", "img": "image 41.png", "text": "Vegetables & Fruits"},
  ];

  final List<Map<String, String>> secondgrocery = [
    {"img": "image 21.png", "text": "Dry Fruits & Cereals"},
    {"img": "image 22.png", "text": "Kitchen & Appliances"},
    {"img": "image 23.png", "text": "Tea & Coffees"},
    {"img": "image 24.png", "text": "Ice Creams & much more"}
  ];

  final List<Map<String, String>> snacksanddrinks = [
    {"img": "image 35.png", "text": "Beauty & Cosmetics"},
    {"img": "image 36.png", "text": "Skin Care"},
    {"img": "image 37.png", "text": "Hair Care"},
    {"img": "image 38.png", "text": "Makeup"}
  ];

  final List<Map<String, String>> beauty = [
   {"img": "image 39.png", "text": "Cleaning Essentials"},
    {"img": "image 40.png", "text": "Home Utilities"},
    {"img": "image 41.png", "text": "Kitchen Tools"},
    {"img": "image 42.png", "text": "Laundry Care"}
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
    final int crossAxisCount = (MediaQuery.of(context).size.width / 90).floor();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// 🔹 Status bar padding (colored background)
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppsColors.primary,
          ),

          /// 🔹 Main Scrollable Content
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: Container(color: AppsColors.primary)),

                /// Header (App Name + Info)
                SliverToBoxAdapter(
                  child: Container(
                    color: AppsColors.primary, // Background white
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// 🔹 Left logo box
                            InkWell(
                              borderRadius: BorderRadius.circular(
                                50,
                              ), // 👈 ripple circle ke andar rahe
                              onTap: () {
                                NavHelper.goToProfile();
                              },
                              child: Container(
                                width: 35.w,
                                height: 35.w,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 250, 250, 250),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 22.sp,
                                    color: AppsColors.primary,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 12.w),

                            /// 🔹 Center App name + info
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

                            /// 🔹 Right side (icons)
                            Row(
                              children: [
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () {
                                    print("Notifications clicked!");
                                    // 👇 yahan aap apna navigation ya API call kar sakte ho
                                    NavHelper.goTowishlist();
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 30.w,
                                        height: 30.w,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                            255,
                                            255,
                                            255,
                                            255,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.favorite_outline,
                                          size: 20.sp,
                                          color: AppsColors.primary,
                                        ),
                                      ),
                                      Positioned(
                                        right: -2,
                                        top: -2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            "5",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 10.w),
                                // Notification Button
                                GestureDetector(
                                  onTap: () {
                                    print("Notifications clicked!");
                                    // 👇 yahan aap apna navigation ya API call kar sakte ho
                                    NavHelper.goTonotificatin();
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: 30.w,
                                        height: 30.w,
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                            255,
                                            255,
                                            255,
                                            255,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.notifications_none,
                                          size: 20.sp,
                                          color: AppsColors.primary,
                                        ),
                                      ),
                                      Positioned(
                                        right: -2,
                                        top: -2,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            "5",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),

                /// Sticky Search Bar
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

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Top welcome banner with bags
                      Stack(
                        children: [
                          // Main Content Container (background color, text, images, etc.)
                          Container(
                            height: 80,

                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppsColors.primary,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SmartCachedImage(
                                  imageUrl:
                                      "https://res.cloudinary.com/dlhbrpbfr/image/upload/w_470,ar_1200:1200,c_fit,f_auto,q_80/v1757772213/homepage1_qmr7uw.png",
                                  width: 50,
                                  height: 50,
                                ),

                                // Center text block
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        width: 180,

                                        "assets/images/welcome.png",
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(height: 5),
                                      Transform(
                                        transform: Matrix4.identity()
                                          ..rotateX(-0.1),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Maggi Ban’ne Se Pehle Delivery",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,

                                            shadows: [
                                              Shadow(
                                                blurRadius: 6,
                                                color: Colors.black.withOpacity(
                                                  0.4,
                                                ),
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SmartCachedImage(
                                  imageUrl:
                                      "https://res.cloudinary.com/dlhbrpbfr/image/upload/w_470,ar_1200:1200,c_fit,f_auto,q_80/v1757772213/homepage2_vdarqj.png",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ),

                          // Offers Banner at absolute bottom, overlaying the container
                          // Positioned(
                          //   left: 0,
                          //   right: 0,
                          //   bottom: -5, // Slight overlap as per your image
                          //   child: Container(
                          //    margin: EdgeInsets.symmetric(horizontal: 80),
                          //     height: 25,
                          //     decoration: BoxDecoration(
                          //        color: Color(0xffF1C12F),
                          //       borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(40),
                          //         topRight: Radius.circular(40),
                          //       ),
                          //       boxShadow: [

                          //       ],
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text('✦', style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 109, 76, 10),)),
                          //         SizedBox(width: 5),
                          //         Text(
                          //           "OFFERS FOR YOU",
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 12,
                          //             color: Color.fromARGB(255, 109, 76, 10),
                          //             letterSpacing: 2,
                          //           ),
                          //         ),
                          //         SizedBox(width: 5),
                          //         Text('✦', style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 109, 76, 10),)),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),

                      // Container(
                      //   width: double.infinity,
                      //   height: 70,
                      // color: Color(0xffF1C12F),
                      //   child: Column(
                      //     children: [
                      //       PromoOfferList(),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),

                /// 🔹 Sections with Grid
                SliverToBoxAdapter(child: _SectionTitle("Grocery & Kitchen")),
                _buildGridList(grocerykitchen, crossAxisCount),

SliverToBoxAdapter(child: _SectionTitle("secondgrocery")),
                _buildGridList(secondgrocery, crossAxisCount),

                SliverToBoxAdapter(child: _SectionTitle("beauty")),
                _buildGridList(beauty, crossAxisCount),
                SliverToBoxAdapter(child: _SectionTitle("snacksanddrinks")),
                _buildGridList(snacksanddrinks, crossAxisCount),
                /// 🔹 Promo Banner (Blinkit-style, non-sticky)
                SliverToBoxAdapter(
                  child: const PromoBottomCard(
                    message:
                        "Har zaroorat,\nBas kuch minute mein\ndelivered ❤️",
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

  /// 🔹 Grid Builder (Reusable)
  SliverPadding _buildGridList(
    List<Map<String, String>> data,
    int crossAxisCount, {
    bool showText = true,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 1.h,
          crossAxisSpacing: 1.w,
          childAspectRatio: 80 / 120,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _GridItemWidget(
            data: data[index],
            showText: showText,
           
          ),
          childCount: data.length,
        ),
      ),
    );
  }
}

/// 🔹 Sticky Search Bar Delegate
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

/// 🔹 Grid Item (Each Category Card)
class _GridItemWidget extends StatelessWidget {
  final Map<String, String> data;
  final bool showText;
 // ✅ unique hero tag

  const _GridItemWidget({
    required this.data,
    this.showText = true,
   
  });

  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
  GestureDetector(
    onTap: () {
      NavHelper.goTocategorydetails(); // fixed function name
    },
    child: Container(
      color: Colors.white,
      height: 120.h,
      width: 100.w,
      child: UiHelper.CustomImage(
        img: data["img"]?.toString() ?? '',
      ),
    ),
  ),
  if (showText == true)
    Text(
      data["text"]?.toString() ?? '',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 13.sp),
    ),
],

    );
  }
}

/// 🔹 Section Title
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
