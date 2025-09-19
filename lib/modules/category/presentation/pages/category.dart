// lib/features/categories/presentation/pages/categories_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/category/domain/entities/category_entity.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_bloc.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_event.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/presentation/widgets/noglowbehavour.dart';
import '../../../../presentation/widgets/bottomfootercard.dart';
import '../../../../presentation/widgets/searchbarwidget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    super.initState();
    // ✅ Page open hone par hi API call
    Future.microtask(() {
      context.read<CategoriesBloc>().add(CategoriesRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = (MediaQuery.of(context).size.width / 90).floor();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          switch (state.status) {
            case CategoriesStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case CategoriesStatus.failure:
              return Center(child: Text(state.error ?? "Something went wrong"));
            case CategoriesStatus.success:
              final categories = state.categories;
              return _buildCategoriesView(categories, crossAxisCount);
            case CategoriesStatus.initial:
            default:
              return const Center(child: Text("Explore categories here 👇"));
          }
        },
      ),
    );
  }

  Widget _buildCategoriesView(
    List<ParentCategoryEntity> categories,
    int crossAxisCount,
  ) {
    final DashboardController controller = Get.find<DashboardController>();

    /// 🔹 Responsive calculation for 3-column grid
    final screenWidth = MediaQuery.of(context).size.width;
    final itemHeight = 155.h;
    final totalHorizontalPadding = 0.w;
    final crossAxisSpacing = 0.w;

    final itemWidth =
        (screenWidth - totalHorizontalPadding - (2 * crossAxisSpacing)) / 3;

    final childAspectRatio = itemWidth / itemHeight;
    return Column(
      children: [
        // Status bar padding
        Container(
          height: MediaQuery.of(context).padding.top,
          color: AppsColors.primary,
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: NoGlowBehavior(), // 👈 yahan use karo
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(), // 👈 yeh lagao
              slivers: [
                // Header
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
                                  children: const [
                                    TextSpan(
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

                // Search Bar
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
                SliverToBoxAdapter(
                  child: SizedBox(height: 10), // ⬅ gap after header
                ),
                // Categories Grid
                for (ParentCategoryEntity parent in categories) ...[
                  SliverToBoxAdapter(child: _SectionTitle(parent.parentName)),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 1.h,
                        crossAxisSpacing: 10.w,
                        childAspectRatio: 80 / 120,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _GridItemWidget(data: parent.categories[index]),
                        childCount: parent.categories.length,
                      ),
                    ),
                  ),
                ],

                // Bottom Promo
                const SliverToBoxAdapter(
                  child: PromoBottomCard(
                    message:
                        "Har zaroorat,\nBas kuch minute mein\ndelivered ❤️",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Sticky SearchBar
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

// Grid Item
class _GridItemWidget extends StatelessWidget {
  final SubCategoryEntity data;
  const _GridItemWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90.h,
          width: 90.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: const Color.fromARGB(248, 255, 255, 255),
          ),
          child: SmartCachedImage(imageUrl: data.image),
        ),
        Text(
          data.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}

// Section Title
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
return Padding(
  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
      ),
      SizedBox(height: 2.h),
      Row(
        children: [
          Text(
            "Earphones, chargers & more — all in one place",
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Divider(
              thickness: 1,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
       SizedBox(width: 5.w),
    ],
  ),
);

}
}
