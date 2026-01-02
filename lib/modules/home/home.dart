import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/modules/banner/domain/entities/banner_entity.dart';
import 'package:mohalla_bazaar/modules/banner/presentation/bloc/banner_bloc.dart';
import 'package:mohalla_bazaar/modules/banner/presentation/bloc/banner_event.dart';
import 'package:mohalla_bazaar/modules/banner/presentation/bloc/banner_state.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_event.dart';
import 'package:mohalla_bazaar/modules/home_category_products/presentaton/bloc/home_category_products_bloc.dart';
import 'package:mohalla_bazaar/modules/home_category_products/presentaton/bloc/home_category_products_event.dart';
import 'package:mohalla_bazaar/modules/home_category_products/presentaton/bloc/home_category_products_state.dart';
import 'package:mohalla_bazaar/modules/home_category_products/presentaton/pages/HomeCategoryProductsPage.dart';
import 'package:mohalla_bazaar/modules/notification/presentation/bloc/notification_bloc.dart';
import 'package:mohalla_bazaar/modules/notification/presentation/bloc/notification_event.dart';
import 'package:mohalla_bazaar/modules/orderhistory/presentation/bloc/orderhistory_bloc.dart';
import 'package:mohalla_bazaar/modules/orderhistory/presentation/bloc/orderhistory_event.dart';
import 'package:mohalla_bazaar/modules/parent_category/domain/entities/parent_category_entity.dart';
import 'package:mohalla_bazaar/modules/parent_category/presentation/bloc/parent_category_bloc.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/bloc/parent_category_details_bloc.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/bloc/parent_categorydetails_event.dart';
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
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_event.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/widgets/cartcount_badge.dart';

// ------------------ Main Page Widget ------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  final Map<String, dynamic> buyAgainJson = {
    "heading": "Your Time, Our Priority—Delivered Fast",
    "subtitle": "Shop By Store",
  };
  late List<BannerEntity> banners;

  @override
  void initState() {
    super.initState();

    banners = [];
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    final box = GetStorage();
    final userid = box.read("userid");
    // Use Future.microtask for a more immediate but safe scheduling
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoriesBloc>().add(CategoriesRequested());
      context.read<ParentCategoryBloc>().add(ParentCategoryRequested());
      context.read<BannerBloc>().add(BannerRequested());
      context.read<HomeCategoryProductsBloc>().add(
        HomeCategoryProductsRequested(),
      );

      // 🔹 Trigger these only if userId is available
      if (userid != null && userid is String && userid.isNotEmpty) {
        context.read<CartCountBloc>().add(LoadCartCount(userid));
        context.read<ViewCartBloc>().add(LoadViewCart(userId: userid));
        context.read<OrderHistoryBloc>().add(LoadOrderHistory(userid));
        context.read<NotificationBloc>().add(NotificationRequested(userid));
      } else {}
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
    Get.put(DashboardController());

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
                // const SliverToBoxAdapter(child: _GifBanner()),
                SliverToBoxAdapter(child: _BuyAgainSection(buyAgainJson)),

                BlocBuilder<ParentCategoryBloc, ParentCategoryState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case ParentCategoryStatus.success:
                        if (state.categories.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(), // ya "No categories" text
                          );
                        }
                        return SliverToBoxAdapter(
                          child: _BuyAgainCategories(state.categories),
                        );

                      // Cache/failure/empty ke liye blink avoid → ya placeholder chhota rakho
                      default:
                        return const SliverToBoxAdapter(
                          child: SizedBox.shrink(),
                        );
                    }
                  },
                ),
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
                SliverToBoxAdapter(
                  child: BlocListener<BannerBloc, BannerState>(
                    listener: (context, state) {
                      if (state.status == BannerStatus.success) {
                        banners = state.banners;
                      }
                    },
                    child: Container(), // now safe
                  ),
                ),

                BlocBuilder<
                  HomeCategoryProductsBloc,
                  HomeCategoryProductsState
                >(
                  builder: (context, state) {
                    if (state.status == HomeCategoryProductsStatus.loading) {
                      return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state.status == HomeCategoryProductsStatus.failure) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            "Error: ${state.error}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    }

                    if (state.status == HomeCategoryProductsStatus.success &&
                        state.categories.isNotEmpty) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final category = state.categories[index];
                          return CategoryTile(category: category);
                        }, childCount: state.categories.length),
                      );
                    }

                    return const SliverToBoxAdapter(
                      child: Center(child: Text("No Categories Found")),
                    );
                  },
                ),

                const SliverToBoxAdapter(
                  child: PromoBottomCard(
                    message:
                        "Har zaroorat,\nBas kuch minute mein\ndelivered ❤️",
                  ),
                ),
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
  const _Header({required this.mediaQueryPaddingTop});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppsColors.primary,
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 5.w),
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
          SizedBox(width: 5.w),
          _IconCircle(
            icon: Icons.notifications_none,
            onTap: NavHelper.goTonotificatin,
            size: 30.w,
            bgColor: Colors.white,
            iconColor: AppsColors.primary,
            iconSize: 20.sp,
          ),
          SizedBox(width: 5.w),
          Shoppingcircle(
            icon: Icons.shopping_cart,
            onTap: NavHelper.goToCartFromProductsDetails,
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

class Shoppingcircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color bgColor;
  final Color iconColor;
  final double iconSize;
  final int badgeCount;

  const Shoppingcircle({
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
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Color(0xFFEC407A),
                  shape: BoxShape.circle,
                ),
                child: CartCountText(fontSize: 9),
              ),
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

  const _IconCircle({
    required this.icon,
    required this.onTap,
    required this.size,
    required this.bgColor,
    required this.iconColor,
    required this.iconSize,
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
        ],
      ),
    );
  }
}

// ------------------ Banner ------------------

class _GifBanner extends StatelessWidget {
  const _GifBanner();

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
                            color: const Color.fromRGBO(0, 0, 0, 0.4),
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
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
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
  final List<ParentCategoryhomeEntity> categories;

  const _BuyAgainCategories(this.categories);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // important if inside another scroll view
      physics: const NeverScrollableScrollPhysics(), // optional
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // number of columns
        mainAxisSpacing: 0.h, // vertical spacing
        crossAxisSpacing: 0.w, // horizontal spacing
        childAspectRatio: 1, // width / height ratio
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            context.read<ParentCategoryDetailsBloc>().add(
              ParentCategoryDetailsRequested(category.parentCategoryId),
            );
            NavHelper.goToparentcategorydetails(category.parentCategoryId);
          },
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
                width: 60.w,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r), // rounded corners
                    border: Border.all(
                      color: Colors.grey.shade300, // border color
                      width: 1, // border width
                    ),
                  ),
                  padding: EdgeInsets.all(
                    4.w,
                  ), // <-- gap between border and image
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.r),
                    child: SmartCachedImage(
                      imageUrl: category.parentCategoryImage,
                      fit: BoxFit.cover, // fit the image inside the border
                    ),
                  ),
                ),
              ),

              SizedBox(height: 4.h),
              Text(
                category.parentCategoryName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.sp, color: AppsColors.textDark),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ------------------ Categories ------------------

class _CategoriesListView extends StatelessWidget {
  final List<ParentCategoryEntity> categories;
  const _CategoriesListView({required this.categories});

  @override
  Widget build(BuildContext context) {
    final allItems = categories.expand((p) => p.categories).toList();

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Heading
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Text(
              "Shop By Category",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          // ✅ FIXED GridView
          GridView.builder(
            shrinkWrap: true, // 🔥 very important
            physics: const NeverScrollableScrollPhysics(), // 🔥 important
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 0.h,
              crossAxisSpacing: 0.w,
              childAspectRatio: 1, // width / height ratio
            ),
            itemCount: allItems.length,
            itemBuilder: (context, index) {
              return CategoryGridItem(data: allItems[index]);
            },
          ),
        ],
      ),
    );
  }
}

class CategoryGridItem extends StatelessWidget {
  final CategoryEntity data;
  const CategoryGridItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final box = GetStorage();
        box.write('categoryId', data.categoryId);
        NavHelper.goTocategorydetails();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,

      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: SmartCachedImage(
                imageUrl: data.image,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            data.name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 10.sp),
            maxLines: 2, // ✅ 2 lines tak limit
            overflow: TextOverflow.ellipsis,
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
