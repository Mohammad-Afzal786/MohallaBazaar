import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:shimmer/shimmer.dart';

import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/category/domain/entities/category_entity.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_bloc.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_event.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_state.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';

import 'package:mohalla_bazaar/presentation/widgets/noglowbehavour.dart';
import '../../../../presentation/widgets/bottomfootercard.dart';
import '../../../../presentation/widgets/searchbarwidget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoriesBloc>().add(CategoriesRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = (screenWidth / 90).floor(); // responsive grid
    final DashboardController controller = Get.find<DashboardController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Status bar overlay
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppsColors.primary,
          ),

          // Header
          _Header(controller: controller),

          // Search bar
          Container(
            color: AppsColors.primary,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: const SearchBarWidget(),
          ),

          // Categories content
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              buildWhen: (prev, curr) => prev.status != curr.status,
              builder: (context, state) {
                switch (state.status) {
                  case CategoriesStatus.loading:
                  case CategoriesStatus.initial:
                    return CategoryShimmerGrid(crossAxisCount: crossAxisCount);

                  case CategoriesStatus.failure:
                    return Center(
                      child: Text(
                        state.error ?? "Something went wrong",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    );

                  case CategoriesStatus.success:
                    return _CategoriesListView(
                      categories: state.categories,
                      crossAxisCount: crossAxisCount,
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Responsive Header
class _Header extends StatelessWidget {
  final DashboardController controller;
  const _Header({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    style: TextStyle(fontSize: 25.sp, color: Colors.white),
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
                  style: TextStyle(fontSize: 12.sp, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Responsive categories grid
class _CategoriesListView extends StatelessWidget {
  final List<ParentCategoryEntity> categories;
  final int crossAxisCount;

  const _CategoriesListView({
    required this.categories,
    required this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoGlowBehavior(),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          for (final parent in categories) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: SectionTitle(parent.parentName, parent.parentSubtitle),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // number of columns
                  mainAxisSpacing: 0.h, // vertical spacing
                  crossAxisSpacing: 0.w, // horizontal spacing
                  childAspectRatio: 1, // width / height ratio
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      CategoryGridItem(data: parent.categories[index]),
                  childCount: parent.categories.length,
                ),
              ),
            ),
          ],
          const SliverToBoxAdapter(
            child: PromoBottomCard(
              message: "Har zaroorat,\nBas kuch minute mein\ndelivered ❤️",
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        ],
      ),
    );
  }
}

/// Responsive Grid Item
class CategoryGridItem extends StatelessWidget {
  final CategoryEntity data;
  const CategoryGridItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      borderRadius: BorderRadius.circular(15.r),
      onTap: () {
        NavHelper.goTocategorydetails();
        final box = GetStorage();
        box.write("categoryId", data.categoryId);
      },
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
          SizedBox(height: 5.h),
          Text(
            data.name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 10.sp),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Responsive Shimmer
class CategoryShimmerGrid extends StatelessWidget {
  final int crossAxisCount;
  const CategoryShimmerGrid({super.key, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final int placeholderCount = crossAxisCount * 2;

    return Padding(
      padding: EdgeInsets.all(8.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 10.h,
          crossAxisSpacing: 10.w,
          childAspectRatio: 90 / 120,
        ),
        itemCount: placeholderCount,
        itemBuilder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              Container(
                height: 70.h,
                width: 70.w,
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

/// Responsive section title
class SectionTitle extends StatelessWidget {
  final String title;
  final String parentSubtitle;
  const SectionTitle(this.title, this.parentSubtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Row(
        children: [
          _lineGradient(startToEnd: true),
          GradientText(
            title,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            gradient: const LinearGradient(
              colors: [Color(0xFF09B40F), Color(0xFF006E13)],
            ),
          ),
          _lineGradient(startToEnd: false),
        ],
      ),
    );
  }

  Widget _lineGradient({required bool startToEnd}) {
    return Expanded(
      child: Container(
        height: 1.h,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
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

/// Gradient Text
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
          ..shader = gradient.createShader(Rect.fromLTWH(0, 0, 200.w, 70.h)),
      ),
    );
  }
}
