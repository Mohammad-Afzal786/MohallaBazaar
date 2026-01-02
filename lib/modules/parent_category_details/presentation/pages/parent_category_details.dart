import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/widgets/cartcount_badge.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/entities/product_entity.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/entities/parent_categorydetails_entity.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/bloc/parent_category_details_bloc.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/bloc/parent_categorydetails_event.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/bloc/parent_categorydetails_state.dart';
import 'package:mohalla_bazaar/modules/cart/domain/entities/cart_item_entity.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_event.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_event.dart';

class ParentCategoryDetailsPage extends StatefulWidget {
  const ParentCategoryDetailsPage({super.key});

  @override
  State<ParentCategoryDetailsPage> createState() =>
      _ParentCategoryDetailsPageState();
}

class _ParentCategoryDetailsPageState extends State<ParentCategoryDetailsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final selectedCategoryIndex = ValueNotifier<int>(0);
  final selectedSubCategoryId = ValueNotifier<String?>(null);
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  String selectedSortOption = "Relevance (default)";
  bool _isScrollingByTap = false;

  @override
  void dispose() {
    selectedCategoryIndex.dispose();
    selectedSubCategoryId.dispose();
    itemPositionsListener.itemPositions.removeListener(_onScroll);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    final userid = box.read("userid");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userid != null && userid is String && userid.isNotEmpty) {
        context.read<CartCountBloc>().add(LoadCartCount(userid));
      }
    });

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    final parentcategoryId = Get.arguments as String?;
    if (parentcategoryId != null) {
      context.read<ParentCategoryDetailsBloc>().add(
        ParentCategoryDetailsRequested(parentcategoryId),
      );
    }

    itemPositionsListener.itemPositions.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isScrollingByTap) return;
    final positions = itemPositionsListener.itemPositions.value.toList();
    if (positions.isEmpty) return;

    final firstVisible = positions
        .where((p) => p.itemTrailingEdge > 0)
        .reduce((a, b) => a.itemLeadingEdge < b.itemLeadingEdge ? a : b);

    selectedCategoryIndex.value = firstVisible.index;
  }

  Future<void> _onCategoryTap(int index) async {
    selectedCategoryIndex.value = index;
    _isScrollingByTap = true;

    await itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      _isScrollingByTap = false;
    });
  }

 Widget _buildLeftMenu(ParentCategoryDetailsEntity details) {
  final double containerWidth = 80.w; // responsive width
  final double imageSize = 70.w; // responsive image size
  final double verticalPadding = 5.h;
  final double horizontalPadding = 2.w;
  final double spacing = 6.h;

  return Container(
    width: containerWidth,
    color: Colors.white,
    child: ValueListenableBuilder<int>(
      valueListenable: selectedCategoryIndex,
      builder: (_, selectedIndex, __) => ListView.builder(
        itemCount: details.categories.length,
        itemBuilder: (_, index) {
          final s = details.categories[index];
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => _onCategoryTap(index),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: horizontalPadding,
              ),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: isSelected ? 1.08 : 1.0),
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                builder: (context, scale, child) => Transform.scale(
                  scale: scale,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: isSelected
                        ? BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.green,
                                width: 3.w, // responsive border width
                              ),
                            ),
                          )
                        : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: SmartCachedImage(
                            imageUrl: s.categoryImage,
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: spacing),
                        Text(
                          s.categoryName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? Colors.black : Colors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

  List<ProductEntity> _getSortedProducts(ParentCategoryCategoryEntity sub) {
    List<ProductEntity> products = List.from(sub.products);
    switch (selectedSortOption) {
      case "Price (low to high)":
        products.sort(
          (a, b) => a.productdiscountPrice.compareTo(b.productdiscountPrice),
        );
        break;
      case "Price (high to low)":
        products.sort(
          (a, b) => b.productdiscountPrice.compareTo(a.productdiscountPrice),
        );
        break;
      case "Discount (high to low)":
        products.sort(
          (a, b) => b.productsaveAmount.compareTo(a.productsaveAmount),
        );
        break;
      default:
        break;
    }
    return products;
  }

Widget _buildSubcategoryItem(ParentCategoryCategoryEntity sub) {
  final sortedProducts = _getSortedProducts(sub);
  final List<Widget> rows = [];

  for (int i = 0; i < sortedProducts.length; i += 2) {
    final first = sortedProducts[i];
    final second = (i + 1 < sortedProducts.length) ? sortedProducts[i + 1] : null;

    rows.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First product
            Expanded(child: BestsellerCard1(first)),

            SizedBox(width: 5.w),

            // Second product if exists
            if (second != null)
              Expanded(child: BestsellerCard1(second))
            else
              Expanded(child: Container()), // empty space for single item
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      _buildDividerWithTitle(sub.categoryName),
      ...rows,
    ],
  );
}

  // --- FIXED these two methods ---
  Widget _buildDividerWithTitle(String title) => Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Expanded(child: _lineGradient(startToEnd: true)),
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Expanded(child: _lineGradient(startToEnd: false)),
      ],
    ),
  );

  Widget _lineGradient({required bool startToEnd}) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: startToEnd
              ? [Colors.white, const Color(0xFF006E13)]
              : [const Color(0xFF006E13), Colors.white],
        ),
      ),
    );
  }
  // -- END FIXED

  Widget _buildFilterBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () async {
              final selected = await showModalBottomSheet<String>(
                context: context,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  String tempSelected = selectedSortOption;
                  return StatefulBuilder(
                    builder: (context, setStateModal) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sort by",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          for (final opt in const [
                            "Relevance (default)",
                            "Price (low to high)",
                            "Price (high to low)",
                            "Discount (high to low)",
                          ])
                            RadioListTile<String>(
                              activeColor: Colors.green,
                              title: Text(opt),
                              value: opt,
                              groupValue: tempSelected,
                              onChanged: (val) {
                                setStateModal(() => tempSelected = val!);
                                Navigator.pop(context, val);
                              },
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );

              if (selected != null) {
                setState(() => selectedSortOption = selected);
              }
            },
            child: Row(
              children: [
                Icon(CupertinoIcons.slider_horizontal_3, size: 18.sp),
                const SizedBox(width: 4),
                Text(
                  "Sort",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScreenUtilInit(
      designSize: const Size(393, 804),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) NavHelper.backToparentcategorydetails();
          },
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                56.h + MediaQuery.of(context).padding.top,
              ),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).padding.top,
                    color: AppsColors.primary,
                  ),
                  _buildAppBarContent(),
                ],
              ),
            ),
            body:
                BlocBuilder<
                  ParentCategoryDetailsBloc,
                  ParentCategoryDetailsState
                >(
                  builder: (_, state) {
                    if (state.status == ParentCategoryDetailsStatus.loading &&
                        state.details == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.status == ParentCategoryDetailsStatus.failure) {
                      return Center(
                        child: Text('Error: ${state.error ?? "Unknown"}'),
                      );
                    }

                    final details = state.details;
                    if (details == null) {
                      return const Center(child: Text('No data'));
                    }

                    if (details.categories.isNotEmpty) {
                      selectedSubCategoryId.value ??=
                          details.categories.first.categoryId;
                    } else {
                      selectedSubCategoryId.value = null;
                    }

                    return Row(
                      children: [
                        _buildLeftMenu(details),
                        Container(
                          width: 1,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              _buildFilterBar(),
                              Expanded(
                                child: ScrollablePositionedList.builder(
                                  itemCount: details.categories.length,
                                  itemBuilder: (_, index) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 20.h,
                                    ), // ✅ har row ke niche space
                                    child: _buildSubcategoryItem(
                                      details.categories[index],
                                    ),
                                  ),
                                  itemScrollController: itemScrollController,
                                  itemPositionsListener: itemPositionsListener,
                                  physics: const BouncingScrollPhysics(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
          ),
        );
      },
    );
  }

  Widget _buildAppBarContent() => Container(
    color: AppsColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
    child: Row(
      children: [
        // Back button
        GestureDetector(
          onTap: () => NavHelper.backToparentcategorydetails(),
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

        // Title & Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mohalla Bazaar title
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 27.sp, color: Colors.white),
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
              ),
              // Subtitle
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Delivery in 30 minutes",
                  style: TextStyle(fontSize: 12.sp, color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 12.w),

        // Cart Icon
        _IconCircle(
          icon: Icons.shopping_cart,
          onTap: NavHelper.goToCartFromProductsDetails,
          size: 35.w,
          bgColor: Colors.white,
          iconColor: AppsColors.primary,
          iconSize: 20.sp,
          badgeCount: 5,
        ),
      ],
    ),
  );
}

class _IconCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size; // base size
  final Color bgColor;
  final Color iconColor;
  final double iconSize; // base icon size
  final int badgeCount;

  const _IconCircle({
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
    final double responsiveSize = size.w;
    final double responsiveIconSize = iconSize.sp;
    final double badgeRadius = 8.w; // badge radius responsive
    final double badgePadding = 3.w;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: responsiveSize,
            height: responsiveSize,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, size: responsiveIconSize, color: iconColor),
          ),
          if (badgeCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(badgePadding),
                decoration: BoxDecoration(
                  color: const Color(0xFFEC407A),
                  shape: BoxShape.circle,
                ),
                child: CartCountText(fontSize: 12.sp),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------- Product Card ---------------- //

class BestsellerCard1 extends StatefulWidget {
  final ProductEntity product;
  const BestsellerCard1(this.product, {super.key});

  @override
  State<BestsellerCard1> createState() => _BestsellerCard1State();
}

class _BestsellerCard1State extends State<BestsellerCard1>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ValueNotifier<bool> isAdding = ValueNotifier(false);

  @override
  void dispose() {
    isAdding.dispose();
    super.dispose();
  }

  void addToCart(String userid) {
    isAdding.value = true;
    context.read<CartBloc>().add(
          AddCartItemEvent(
            CartItemEntity(
              userId: userid,
              productId: widget.product.productId,
              action: "increment",
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final p = widget.product;
    final userid = GetStorage().read("userid");
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = (screenWidth / 2) - 16.w; // 2 cards per row

    return Container(
      width: cardWidth,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.withOpacity(0.6), width: 0.5.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // auto height
        children: [
          // Image with AspectRatio
          GestureDetector(
            onTap: () {
              GetStorage().write(
                'productslistfromcategorydetailspage',
                widget.product.toJson(),
              );
              NavHelper.goToproducsdetails();
            },
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1, // square image
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: SmartCachedImage(
                      imageUrl: p.productimage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 5.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/discount.svg',
                        width: 40.w,
                        height: 40.h,
                      ),
                      Text(
                        "${calculateDiscountPercent(p.productprice, p.productdiscountPrice).toStringAsFixed(0)}%\nOFF",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Product Info
          Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // auto height
              children: [
                // Time
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 12.sp,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        p.producttime,
                        style: TextStyle(fontSize: 9.sp, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),

                // Name
                Text(
                  p.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),

                // Quantity
                Text(
                  p.productquantity,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppsColors.textclourgray,
                  ),
                ),
                SizedBox(height: 2.h),

                // Save Amount
                if (p.productsaveAmount > 0)
                  Text(
                    "SAVE ₹${p.productsaveAmount}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color.fromARGB(255, 3, 85, 6),
                    ),
                  ),
                SizedBox(height: 4.h),

                // Price + Add Button
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹${p.productdiscountPrice}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        if (p.productprice != p.productdiscountPrice)
                          Text(
                            "₹${p.productprice}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppsColors.textclourgray,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    Spacer(),

                    ValueListenableBuilder<bool>(
                      valueListenable: isAdding,
                      builder: (context, adding, _) => GestureDetector(
                        onTap: adding ? null : () => addToCart(userid),
                        child: Container(
                          width: 50.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: adding ? Colors.grey[300] : Colors.white,
                            border: Border.all(
                              color: const Color(0xffFB5D92),
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: adding
                                ? SizedBox(
                                    width: 12.w,
                                    height: 12.h,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: const Color(0xffFB5D92),
                                    ),
                                  )
                                : Text(
                                    "ADD",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xffFB5D92),
                                    ),
                                  ),
                          ),
                        ),
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

double calculateDiscountPercent(num price, num discountPrice) {
  double originalPrice = price.toDouble();
  double discounted = discountPrice.toDouble();

  if (originalPrice <= 0) return 0;
  double discount = originalPrice - discounted;
  return (discount / originalPrice) * 100;
}
