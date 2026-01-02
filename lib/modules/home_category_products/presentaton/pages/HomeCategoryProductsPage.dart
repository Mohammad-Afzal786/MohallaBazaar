// Path: lib/features/homecategoryproducts/presentation/pages/home_category_products_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_event.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_state.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_event.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_event.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';

/// 🔹 Widget for Category + Horizontal products
class CategoryTile extends StatelessWidget {
  final dynamic category;

  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category heading
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            category.categoryName,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Horizontal products list
        SizedBox(
          height: 340.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.products.length,
            itemBuilder: (context, index) {
              final product = category.products[index];
              return BestsellerCard1(product);
            },
          ),
        ),
        SizedBox(height: 5.h),
      ],
    );
  }
}

/// BestsellerCard1 Widget
class BestsellerCard1 extends StatefulWidget {
  final dynamic product;
  const BestsellerCard1(this.product, {super.key});

  @override
  State<BestsellerCard1> createState() => _BestsellerCard1State();
}

class _BestsellerCard1State extends State<BestsellerCard1>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ValueNotifier<bool> isFavorite = ValueNotifier(false);
  final ValueNotifier<bool> isAdding = ValueNotifier(false);

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

    return Container(
      width: 160.w,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image + discount
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
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.6),
                      width: 0.5.w,
                    ),
                  ),
                  child: SmartCachedImage(
                    imageUrl: p.productimage,
                    width: 140.w,
                    height: 150.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 0.h,
                left: 5.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/discount.svg',
                      width: 30.w,
                    ),
                    Text(
                      "${calculateDiscountPercent(p.productprice ?? 0, p.productdiscountPrice ?? 0).toStringAsFixed(0)}%\nOFF",
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
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 10.sp,
                        color: Colors.black,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "30 min",
                        style: TextStyle(fontSize: 8.sp, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  child: Text(
                    p.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  p.productquantity,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppsColors.textclourgray,
                  ),
                ),
                if (p.productsaveAmount > 0)
                  Text(
                    "SAVE ₹${p.productsaveAmount}",
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 5, 99, 9),
                    ),
                  ),

                // Price + ADD button
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹${p.productdiscountPrice}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        if ((p.productprice ?? 0) != (p.productdiscountPrice ?? 0))
                          Text(
                            "MRP ₹${p.productprice ?? 0}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppsColors.textclourgray,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),

                    // ADD button per-product loading
                    ValueListenableBuilder<bool>(
                      valueListenable: isAdding,
                      builder: (context, adding, _) => GestureDetector(
                        onTap: adding ? null : () => addToCart(userid),
                        child: Container(
                          width: 50.w,
                          height: 30.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
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
                                    height: 12.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: Color(0xffFB5D92),
                                    ),
                                  )
                                : Text(
                                    "ADD",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: const Color(0xffFB5D92),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),

                    // Bloc listener
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
      ),
    );
  }
}

double calculateDiscountPercent(num? price, num? discountPrice) {
  double originalPrice = (price ?? 0).toDouble();
  double discounted = (discountPrice ?? 0).toDouble();
  if (originalPrice <= 0) return 0;
  double discount = originalPrice - discounted;
  return (discount / originalPrice) * 100;
}
