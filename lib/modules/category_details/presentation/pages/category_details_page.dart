import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/cart/domain/entities/cart_item_entity.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_event.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_state.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_event.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_event.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/widgets/cartcount_badge.dart';
import 'package:mohalla_bazaar/modules/home/home.dart';
import '../bloc/category_details_bloc.dart';
import '../bloc/category_details_event.dart';
import '../bloc/category_details_state.dart';
import '../../domain/entities/category_details_entity.dart';

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({super.key});

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  late final String userid;
  late final String categoryId;
  final box = GetStorage();
  @override
  void initState() {
    super.initState();

    userid = box.read("userid") ?? "";
    categoryId = box.read("categoryId") ?? "";
    Future.microtask(() {
      context.read<CartCountBloc>().add(LoadCartCount(userid));
    });
  }

  @override
  void dispose() {
    box.remove("categoryId");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<CategoryDetailsBloc>().add(
      CategoryProductsRequested(categoryId),
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
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
      body: BlocBuilder<CategoryDetailsBloc, CategoryDetailsState>(
        builder: (context, state) {
          if (state.status == CategoryDetailsStatus.loading) {
            return CategoryShimmerGrid(crossAxisCount: 4);
          } else if (state.status == CategoryDetailsStatus.failure) {
            return Center(
              child: Text(
                "${state.error}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state.status == CategoryDetailsStatus.success) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(child: Text("No products available"));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const minItemWidth = 150;

                  // Screen width / minItemWidth = number of columns
                  int crossAxisCount = (constraints.maxWidth / minItemWidth)
                      .floor();

                  // Minimum 4 columns on small screens, max 6
                  crossAxisCount = crossAxisCount.clamp(4, 6);

                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // ✅ 1 row mein 2 items
                      mainAxisSpacing: 10.h, // row spacing
                      crossAxisSpacing: 10.h, // column spacing
                      childAspectRatio: 0.50,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return BestsellerCard1(product);
                    },
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildAppBarContent() => Container(
    color: AppsColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
    child: Row(
      children: [
        GestureDetector(
          onTap: NavHelper.backTocategorydetails,
          child: CircleAvatar(
            radius: 17.5.w,
            backgroundColor: Colors.white,
            child: Icon(
              CupertinoIcons.back,
              size: 22.sp,
              color: AppsColors.primary,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "mohalla ",
                      style: TextStyle(fontFamily: 'Geometry', fontSize: 27),
                    ),
                    TextSpan(
                      text: "bazaar",
                      style: TextStyle(
                        fontFamily: 'Geometry',
                        color: Colors.white,
                        fontSize: 27,
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
        _IconCircle(
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

class _IconCircle extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color bgColor, iconColor;
  final double iconSize;
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
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: size.w / 2, // responsive
          backgroundColor: bgColor,
          child: Icon(
            icon,
            size: iconSize.sp, // responsive
            color: iconColor,
          ),
        ),
        if (badgeCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: CircleAvatar(
              radius: 6.w, // responsive
              backgroundColor: const Color(0xFFEC407A),
              child: CartCountText(fontSize: 10.sp), // responsive
            ),
          ),
      ],
    ),
  );
}

}

/// BestsellerCard1 Widget
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
  final ValueNotifier<bool> isAdding = ValueNotifier(
    false,
  ); // ✅ per-product loading

  @override
  void dispose() {
    isFavorite.dispose();
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product image + favorite + OFF badge
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                GetStorage().write(
                  'productslistfromcategorydetailspage',
                  widget.product.toJson(),
                );
                NavHelper.goToproducsdetails();
              },
              child: Container(
                height: 220.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.6),
                    width: 0.8.w,
                  ),
                ),
                child: Container(
                  color: Colors.white,
                  child: SmartCachedImage(
                    imageUrl: p.productimage,
                    width: double.infinity,

                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/discount.svg',
                    width: 40.w, // responsive width
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

        // Product info
        Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Icon(
                      Icons.watch_later_outlined,
                      size: 12.sp,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      p.producttime,
                      style: TextStyle(
                        fontSize: 9.sp, // ✅ responsive
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                p.productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp, // ✅ responsive
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                p.productquantity,
                style:  TextStyle(
                  fontSize: 12.sp,
                  color: AppsColors.textclourgray,
                ),
              ),
              if (p.productsaveAmount > 0)
                Text(
                  "SAVE ₹${p.productsaveAmount}",
                  style:  TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 6, 92, 9),
                  ),
                ),

              // Price + ADD button
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "₹${p.productdiscountPrice}",
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (p.productprice != p.productdiscountPrice)
                        Text(
                          "MRP ₹${p.productprice}",
                          style:  TextStyle(
                            fontSize: 14.sp,
                            color: AppsColors.textclourgray,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                  Spacer(),

                  // ✅ ADD button per-product loading
                  ValueListenableBuilder<bool>(
                    valueListenable: isAdding,
                    builder: (context, adding, _) => GestureDetector(
                      onTap: adding ? null : () => addToCart(userid),
                      child: Container(
                        width: 50.w,
                        height: 30.h,
                        padding:  EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: adding ? Colors.grey[300] : Colors.white,
                          border: Border.all(
                            color: const Color(0xffFB5D92),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: adding
                              ?  SizedBox(
                                  width: 15.w,
                                  height: 15.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: Color(0xffFB5D92),
                                  ),
                                )
                              :  Text(
                                  "ADD",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xffFB5D92),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),

                  // Listen for Cart success/failure to reset loader
                  BlocListener<CartBloc, CartState>(
                    listener: (context, state) {
                      if (state is CartSuccess) {
                        isAdding.value = false;
                        context.read<CartCountBloc>().add(
                          LoadCartCount(userid),
                        );
                        context.read<ViewCartBloc>().add(
                          LoadViewCart(userId: userid),
                        );
                      } else if (state is CartFailure) {
                        isAdding.value = false;
                      }
                    },
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

double calculateDiscountPercent(int price, int discountPrice) {
  double originalPrice = price.toDouble();
  double discounted = discountPrice.toDouble();

  if (originalPrice <= 0) return 0; // divide by zero se bachne ke liye
  double discount = originalPrice - discounted;
  return (discount / originalPrice) * 100;
}
