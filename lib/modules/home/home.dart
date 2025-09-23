import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/category/domain/entities/category_entity.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_bloc.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_event.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_state.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/presentation/widgets/bottomfootercard.dart';
import 'package:mohalla_bazaar/presentation/widgets/searchbarwidget.dart';

// ------------------ HomePage ------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  final Map<String, dynamic> buyAgainJson = {
    "heading": "Your Time, Our Priority—Delivered Fast",
    "subtitle": "All in One Place",
    "categories": [
      {
        "id": "PC-0001",
        "category_name": "Mobile",
        "category_image":
            "https://img.freepik.com/premium-photo/composition-with-empty-page-candle-mortar-historic-old-pharmacy-bottles-with-label-wooden-background_392895-447325.jpg",
      },
      {
        "id": "PC-0001",
        "category_name": "Dairy Products",
        "category_image":
            "https://img.freepik.com/free-vector/social-media-concept-with-antigravity-smartphone_23-2148276983.jpg",
      },
      
      
    ],
  };

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    Future.microtask(() {
      context.read<CategoriesBloc>().add(CategoriesRequested());
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    Get.put(DashboardController()); // init dashboard controller

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(height: mediaQuery.padding.top, color: AppsColors.primary),
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _Header(mediaQueryPaddingTop: mediaQuery.padding.top),
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
                      child: const SearchBarWidget(),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: _GifBanner()),
                SliverToBoxAdapter(child: _BuyAgainSection(buyAgainJson)),
                SliverToBoxAdapter(child: _BuyAgainCategories(buyAgainJson)),
                BlocBuilder<CategoriesBloc, CategoriesState>(
                  buildWhen: (prev, curr) => prev.status != curr.status,
                  builder: (context, state) {
                    switch (state.status) {
                      case CategoriesStatus.loading:
                      case CategoriesStatus.initial:
                        return const SliverToBoxAdapter(
                          child: CategoryShimmerGrid(crossAxisCount: 4),
                        );
                      case CategoriesStatus.failure:
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text(state.error ?? "Something went wrong"),
                          ),
                        );
                      case CategoriesStatus.success:
                        return _CategoriesListView(
                          categories: state.categories,
                        );
                    }
                  },
                ),
                const SliverToBoxAdapter(
                  child: PromoBottomCard(
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
}

// ------------------ Header ------------------

class _Header extends StatelessWidget {
  final double mediaQueryPaddingTop;
  const _Header({super.key, required this.mediaQueryPaddingTop});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + mediaQueryPaddingTop,
      color: AppsColors.primary,
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        top: mediaQueryPaddingTop,
      ),
      child: Row(
        children: [
          _IconCircle(
            icon: Icons.person,
            onTap: NavHelper.goToProfile,
            size: 35.w,
            bgColor: Colors.white,
            iconColor: AppsColors.primary,
            iconSize: 22.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 27.sp, color: Colors.white),
                    children: const [
                      TextSpan(
                        text: "mohalla ",
                        style: TextStyle(fontFamily: 'Geometry'),
                      ),
                      TextSpan(
                        text: "bazaar",
                        style: TextStyle(fontFamily: 'Geometry'),
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
          _IconCircle(
            icon: Icons.favorite_outline,
            onTap: NavHelper.goTowishlist,
            size: 30.w,
            bgColor: Colors.white,
            iconColor: AppsColors.primary,
            iconSize: 20.sp,
            badgeCount: 5,
          ),
          SizedBox(width: 10.w),
          _IconCircle(
            icon: Icons.notifications_none,
            onTap: NavHelper.goTonotificatin,
            size: 30.w,
            bgColor: Colors.white,
            iconColor: AppsColors.primary,
            iconSize: 20.sp,
            badgeCount: 5,
          ),
        ],
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color bgColor;
  final Color iconColor;
  final double iconSize;
  final int badgeCount;

  const _IconCircle({
    super.key,
    required this.icon,
    required this.onTap,
    required this.size,
    required this.bgColor,
    required this.iconColor,
    required this.iconSize,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, size: iconSize, color: iconColor),
          ),
          if (badgeCount > 0)
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
                  badgeCount.toString(),
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
    );
  }
}

// ------------------ Banner ------------------

class _GifBanner extends StatelessWidget {
  const _GifBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background GIF
          ClipRect(
            child: OverflowBox(
              maxHeight: double.infinity,
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/welcomedesign.gif",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content
          Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/welcome.png", width: 180.w),
                    SizedBox(height: 5.h),
                    Text(
                      "Maggi Ban’ne Se Pehle Delivery",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.4),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------ Buy Again Section ------------------

class _BuyAgainSection extends StatelessWidget {
  final Map<String, dynamic> buyAgainJson;
  const _BuyAgainSection(this.buyAgainJson);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _star(),
              SizedBox(width: 5),
              GradientText(
                buyAgainJson["heading"],
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                gradient: const LinearGradient(
                  colors: [Color(0xFF09B40F), Color(0xFF006E13)],
                ),
              ),
              SizedBox(width: 5),
              _star(),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              _lineGradient(startToEnd: true),
              Text(
                buyAgainJson["subtitle"],
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              _lineGradient(startToEnd: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _star() => Text(
    "*",
    style: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.bold,
      color: AppsColors.primary,
    ),
  );

  Widget _lineGradient({required bool startToEnd}) {
    return Expanded(
      child: Container(
        height: 1,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: startToEnd
                ? [Colors.white, const Color(0xFF006E13)]
                : [const Color(0xFF006E13), Colors.white],
          ),
        ),
      ),
    );
  }

}

class _BuyAgainCategories extends StatelessWidget {
  final Map<String, dynamic> buyAgainJson;
  const _BuyAgainCategories(this.buyAgainJson);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: buyAgainJson["categories"].length,
        itemBuilder: (context, index) {
          final category = buyAgainJson["categories"][index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: InkWell(
              borderRadius: BorderRadius.circular(8), // ripple effect round
              onTap: () {
                // 👉 यहां अपनी navigation या action लिखो
                // Example:
                 NavHelper.goToparentcategorydetails("PC-0001");
               
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          SmartCachedImage(
                            imageUrl: category["category_image"],
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      category["category_name"],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


// ------------------ Categories ------------------

class _CategoriesListView extends StatelessWidget {
  final List<ParentCategoryEntity> categories;
  const _CategoriesListView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 4;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, parentIndex) {
        final parent = categories[parentIndex];
        final int itemCount = min(8, parent.categories.length);

        return Column(
          children: [
            SectionTitle(parent.parentName),
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 10,
                crossAxisSpacing: 15,
                childAspectRatio: 80 / 120,
              ),
              itemCount: itemCount,
              itemBuilder: (context, index) =>
                  CategoryGridItem(data: parent.categories[index]),
            ),
          ],
        );
      }, childCount: categories.length),
    );
  }
}

class CategoryGridItem extends StatelessWidget {
  final CategoryEntity data;
  const CategoryGridItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      onTap: () => NavHelper.goTocategorydetails(),
      child: Column(
        children: [
          Hero(
            tag: data.id,
            child: Container(
              height: 90.h,
              width: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.white,
              ),
              child: SmartCachedImage(imageUrl: data.image),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            data.name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}

class CategoryShimmerGrid extends StatelessWidget {
  final int crossAxisCount;
  const CategoryShimmerGrid({super.key, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final placeholderCount = crossAxisCount * 2;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 80 / 120,
        ),
        itemCount: placeholderCount,
        itemBuilder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              Container(
                height: 90.h,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              SizedBox(height: 5.h),
              Container(
                height: 15.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ Utility Widgets ------------------

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  const GradientText(
    this.text, {
    super.key,
    required this.style,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        foreground: Paint()
          ..shader = gradient.createShader(const Rect.fromLTWH(0, 0, 200, 70)),
      ),
    );
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