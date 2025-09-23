import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/modules/category/domain/entities/category_entity.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/entities/product_entity.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/entities/parent_categorydetails_entity.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/bloc/parent_category_details_bloc.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/bloc/parent_categorydetails_event.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/bloc/parent_categorydetails_state.dart';

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
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    final parentcategoryId = Get.arguments as String?;
    
    if (parentcategoryId != null) {
      context.read<ParentCategoryDetailsBloc>().add(
        ParentCategoryDetailsRequested("PC-0001"),
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
    return Container(
      width: 90,
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
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 6,
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
                          ? const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.green,
                                  width: 3,
                                ),
                              ),
                            )
                          : null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SmartCachedImage(
                              imageUrl: s.categoryImage,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 6),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDividerWithTitle(sub.categoryName),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: sortedProducts.length,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.55,
          ),
          itemBuilder: (_, index) => BestsellerCard1(sortedProducts[index]),
        ),
      ],
    );
  }

  Widget _buildDividerWithTitle(String title) => Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.shade400,
            thickness: 0.8,
            endIndent: 10,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey.shade400,
            thickness: 0.8,
            indent: 10,
          ),
        ),
      ],
    ),
  );

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

              if (selected != null)
                setState(() => selectedSortOption = selected);
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) NavHelper.backToparentcategorydetails();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
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
            BlocBuilder<ParentCategoryDetailsBloc, ParentCategoryDetailsState>(
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
                if (details == null)
                  return const Center(child: Text('No data'));

                if (details.categories.isNotEmpty) {
                  selectedSubCategoryId.value ??=
                      details.categories.first.categoryId;
                } else {
                  selectedSubCategoryId.value = null;
                }

                return Row(
                  children: [
                    _buildLeftMenu(details),
                    Container(width: 1, color: Colors.grey.withOpacity(0.3)),
                    Expanded(
                      child: Column(
                        children: [
                          _buildFilterBar(),
                          Expanded(
                            child: ScrollablePositionedList.builder(
                              itemCount: details.categories.length,
                              itemBuilder: (_, index) => _buildSubcategoryItem(
                                details.categories[index],
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
  }

  Widget _buildAppBarContent() => Container(
    color: AppsColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
    child: Row(
      children: [
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
  final ValueNotifier<bool> isFavorite = ValueNotifier(false);

  @override
  void dispose() {
    isFavorite.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final p = widget.product;
    return GestureDetector(
      onTap: () {
        final box = GetStorage();
    box.write('productslistfromparentcategorydetailspage', widget.product.toJson());
    NavHelper.goToproducsdetails(); // Navigation
      } ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.6),
                          width: 0.5,
                        ),
                      ),
                      child: SmartCachedImage(
                        imageUrl: p.productimage,
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: isFavorite,
                      builder: (_, fav, __) => GestureDetector(
                        onTap: () => isFavorite.value = !fav,
                        child: Icon(
                          fav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        "Bestseller",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPriceRow(p),
                const SizedBox(height: 4),
                Text(
                  p.productquantity,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppsColors.textclourgray,
                  ),
                ),
                if (p.productsaveAmount > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    "SAVE ₹${p.productsaveAmount}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppsColors.savetextclour,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  p.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.sp),
                ),
                const SizedBox(height: 6),
                _buildRatingRow(p),
                const SizedBox(height: 6),
                Text(
                  p.producttime,
                  style: TextStyle(
                    color: AppsColors.textclourgray,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildPriceRow(ProductEntity p) => Row(
    children: [
      Text(
        "₹${p.productdiscountPrice}",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.sp),
      ),
      const SizedBox(width: 5),
      if (p.productprice != p.productdiscountPrice)
        Text(
          "₹${p.productprice}",
          style: TextStyle(
            fontSize: 11.sp,
            color: AppsColors.textclourgray,
            decoration: TextDecoration.lineThrough,
          ),
        ),
    ],
  );

  Row _buildRatingRow(ProductEntity p) => Row(
    children: [
      Icon(Icons.star, color: Colors.green, size: 16.sp),
      const SizedBox(width: 3),
      Text(
        p.productratag.toString(),
        style: TextStyle(fontSize: 12.sp, color: Colors.green),
      ),
      const SizedBox(width: 4),
      Text(
        "(${p.productreviews})",
        style: TextStyle(fontSize: 10.sp, color: AppsColors.textclourgray),
      ),
    ],
  );
}
