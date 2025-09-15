import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/modules/deshboard/widgets/uihelper.dart';
import 'package:mohalla_bazaar/presentation/widgets/searchbarwidget.dart';

import '../../presentation/widgets/bottomfootercard.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final TextEditingController searchController = TextEditingController();
  final DashboardController controller = Get.find<DashboardController>();
  final ScrollController _scrollController = ScrollController();
  double _lastOffset = 0;
  final double _threshold = 5;

  /// 🔹 Mock Data (You can fetch from API later)
  final List<Map<String, String>> grocerykitchen = [
    {"img": "image 41.png", "text": "Vegetables & \nFruits"},
    {"img": "image 42.png", "text": "Atta, Dal & \nRice"},
    {"img": "image 43.png", "text": "Oil, Ghee & \nMasala"},
    {"img": "image 44 (1).png", "text": "Dairy, Bread & \nMilk"},
    {"img": "image 45 (1).png", "text": "Biscuits & \nBakery"},
    {"img": "image 42.png", "text": "Atta, Dal & \nRice"},
    {"img": "image 43.png", "text": "Oil, Ghee & \nMasala"},
    {"img": "image 44 (1).png", "text": "Dairy, Bread & \nMilk"},
  ];

  final List<Map<String, String>> secondgrocery = [
    {"img": "image 21.png", "text": "Dry Fruits &\n Cereals"},
    {"img": "image 22.png", "text": "Kitchen &\n Appliances"},
    {"img": "image 23.png", "text": "Tea & \nCoffees"},
    {"img": "image 24.png", "text": "Ice Creams & \nmuch more"},
    {"img": "image 22.png", "text": "Kitchen &\n Appliances"},
    {"img": "image 23.png", "text": "Tea & \nCoffees"},
    {"img": "image 21.png", "text": "Dry Fruits &\n Cereals"},
    {"img": "image 23.png", "text": "Tea & \nCoffees"},
  ];

  final List<Map<String, String>> snacksanddrinks = [
    {"img": "image 31.png", "text": "Chips &\n Namkeens"},
    {"img": "image 32.png", "text": "Sweets & \nChocolates"},
    {"img": "image 33.png", "text": "Drinks & \nJuices"},
    {"img": "image 31.png", "text": "Chips &\n Namkeens"},
    {"img": "image 32.png", "text": "Sweets & \nChocolates"},
    {"img": "image 32.png", "text": "Sweets & \nChocolates"},
    {"img": "image 33.png", "text": "Drinks & \nJuices"},
    {"img": "image 34.png", "text": "Sauces &\n Spreads"},
  ];

  final List<Map<String, String>> beauty = [
    {"img": "image 35.png", "text": "Beauty &\n Cosmetics"},
    {"img": "image 36.png", "text": "Skin Care"},
    {"img": "image 37.png", "text": "Hair Care"},
    {"img": "image 38.png", "text": "Makeup"},
    {"img": "image 36.png", "text": "Skin Care"},
    {"img": "image 37.png", "text": "Hair Care"},
    {"img": "image 37.png", "text": "Hair Care"},
    {"img": "image 38.png", "text": "Makeup"},
  ];

  final List<Map<String, String>> household = [
    {"img": "image 39.png", "text": "Cleaning Essentials"},
    {"img": "image 40.png", "text": "Home Utilities"},
    {"img": "image 41.png", "text": "Kitchen Tools"},
    {"img": "image 42.png", "text": "Laundry Care"},
    {"img": "image 39.png", "text": "Cleaning Essentials"},
    {"img": "image 40.png", "text": "Home Utilities"},
    {"img": "image 41.png", "text": "Kitchen Tools"},
    {"img": "image 42.png", "text": "Laundry Care"},
  ];
  // Create all other lists as per your original code

  @override
  void initState() {
    super.initState();
    double scrollDelta = 0;
    _scrollController.addListener(() {
      final currentOffset = _scrollController.offset;
      final delta = currentOffset - _lastOffset;
      scrollDelta += delta;
      if (scrollDelta > _threshold && controller.isBottomNavVisible.value) {
        controller.hideBottomNav();
        scrollDelta = 0;
      } else if (scrollDelta < -_threshold &&
          !controller.isBottomNavVisible.value) {
        controller.showBottomNav();
        scrollDelta = 0;
      }
      _lastOffset = currentOffset;
    });
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = (MediaQuery.of(context).size.width / 90).floor();
    final DashboardController controller = Get.put(DashboardController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppsColors.primary,
          ),
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    color: AppsColors.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
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
                                      style: TextStyle(
                                        fontSize: 27.sp,
                                       
                                        color: Colors.white,
                                      ),
                                      children: [
                                        const TextSpan(text: "mohalla ",style: TextStyle(
   fontFamily: 'Geometry',
                                             
                                        )),
                                        TextSpan(
                                          text: "bazaar",
                                          
                                          style: TextStyle(
                                             fontFamily: 'Geometry',
                                             
                                            color: Color(0xffffffff)),
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

                /// 🔹 Sections with Grid
                SliverToBoxAdapter(child: _SectionTitle("Grocery & Kitchen")),
                _buildGridList(grocerykitchen, crossAxisCount),

                SliverToBoxAdapter(child: _SectionTitle("Daily Needs")),
                _buildGridList(secondgrocery, crossAxisCount),

                SliverToBoxAdapter(child: _SectionTitle("Snacks & Drinks")),
                _buildGridList(snacksanddrinks, crossAxisCount),

                SliverToBoxAdapter(
                  child: _SectionTitle("Beauty & Personal Care"),
                ),
                _buildGridList(beauty, crossAxisCount),

                SliverToBoxAdapter(
                  child: _SectionTitle("Household Essentials"),
                ),
                _buildGridList(household, crossAxisCount),

                // Add all your categories with same pattern
                SliverToBoxAdapter(

                  child:const PromoBottomCard(
        message: "Har zaroorat,\nBas kuch minute mein\ndelivered ❤️",
      ),
                  
                   
                ),

                // Yahan niche conditionally space add karo
              ],
            ),
          ),
        ],
      ),
    );
  }

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
          childAspectRatio: 90 / 120,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              _GridItemWidget(data: data[index], showText: showText),
          childCount: data.length,
        ),
      ),
    );
  }
}

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

class _GridItemWidget extends StatelessWidget {
  final Map<String, String> data;
  final bool showText;
  const _GridItemWidget({required this.data, this.showText = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 78.h,
          width: 71.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: const Color.fromARGB(248, 247, 248, 255),
          ),
          child: UiHelper.CustomImage(img: data["img"].toString()),
        ),
        if (showText)
          Padding(
            padding: EdgeInsets.only(top: 3.h),
            child: Text(
              data["text"].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 100, 97, 97),
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}


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

