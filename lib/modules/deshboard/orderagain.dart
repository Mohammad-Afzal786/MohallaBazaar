import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mohalla_bazaar/core/constants/app_images.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/presentation/widgets/searchbarwidget.dart';

import '../../presentation/widgets/bottomfootercard.dart';

/// 🔹 Category Page
/// Responsive UI with ScreenUtil + Clean Code
class Orderagain extends StatefulWidget {
  const Orderagain({super.key});

  @override
  State<Orderagain> createState() => _OrderagainState();
}

class _OrderagainState extends State<Orderagain> {
  final TextEditingController searchController = TextEditingController();

  /// 🔹 Mock Products
  final List<Map<String, dynamic>> products = [
    {
      "image": "image 31.png",
      "productName": "Amul Gold Full Cream Milk",
      "quantity": "1 pc",
      "price": 40, // original price
      "discountPrice": 35, // offer price
      "saveAmount": 5, // kitna bacha
      "rating": 4.5,
      "reviews": "5.05 lac",
      "time": "10 MINS",
    },
    {
      "image": "image 31.png",
      "productName": "Mother Dairy Classic Pouch Curd",
      "quantity": "1 pc",
      "price": 42,
      "discountPrice": 35,
      "saveAmount": 7,
      "rating": 4.7,
      "reviews": "64,064",
      "time": "10 MINS",
    },
    {
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },
    {
      "image": "image 31.png",
      "productName": "Mother Dairy Classic Pouch Curd",
      "quantity": "1 pc",
      "price": 42,
      "discountPrice": 35,
      "saveAmount": 7,
      "rating": 4.7,
      "reviews": "64,064",
      "time": "10 MINS",
    },
    {
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },
    {
      "image": "image 31.png",
      "productName": "Amul Gold Full Cream Milk",
      "quantity": "1 pc",
      "price": 40, // original price
      "discountPrice": 35, // offer price
      "saveAmount": 5, // kitna bacha
      "rating": 4.5,
      "reviews": "5.05 lac",
      "time": "10 MINS",
    },
    {
      "image": "image 31.png",
      "productName": "Mother Dairy Classic Pouch Curd",
      "quantity": "1 pc",
      "price": 42,
      "discountPrice": 35,
      "saveAmount": 7,
      "rating": 4.7,
      "reviews": "64,064",
      "time": "10 MINS",
    },
    {
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },
    {
      "image": "image 31.png",
      "productName": "Mother Dairy Classic Pouch Curd",
      "quantity": "1 pc",
      "price": 42,
      "discountPrice": 35,
      "saveAmount": 7,
      "rating": 4.7,
      "reviews": "64,064",
      "time": "10 MINS",
    },
    {
      "image": "image 31.png",
      "productName": "Uncle Chipps Spicy Treat Flavour Potato Chips",
      "quantity": "1 pc",
      "price": 25,
      "discountPrice": 20,
      "saveAmount": 5,
      "rating": 4.4,
      "reviews": "2.08 lac",
      "time": "10 mins",
    },
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

    /// 🔹 Responsive calculation for 3-column grid
    final screenWidth = MediaQuery.of(context).size.width;
    final itemHeight = 350.h;
    final totalHorizontalPadding = 20.w;
    final crossAxisSpacing = 8.w;

    final itemWidth =
        (screenWidth - totalHorizontalPadding - (2 * crossAxisSpacing)) / 3;

    final childAspectRatio = itemWidth / itemHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// 🔹 Status bar padding
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppsColors.primary,
          ),

          /// 🔹 Main Scrollable Content
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                /// Header
                SliverToBoxAdapter(
                  child: Container(
                    color: AppsColors.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Back Button
                        GestureDetector(
                          onTap: () => controller.changeTab(0),
                          child: Container(
                            width: 35.w,
                            height: 35.w,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
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

                        /// Title
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
                                      style: TextStyle(fontFamily: 'Geometry'),
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
                      ],
                    ),
                  ),
                ),

                /// 🔹 Sticky Search Bar
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

                /// 🔹 Empty State Info
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 18),
                        Image.asset(
                          AppImages.orderagain,
                          width: 200,
                          height: 200,
                        ),
                        Text(
                          'Reordering will be easy',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                            'Items you order will show up here so you can buy them again easily',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 🔹 Section Title
                SliverToBoxAdapter(child: _SectionTitle("Best Sellers")),

                /// 🔹 Product Grid (3 items per row)
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: crossAxisSpacing,
                    childAspectRatio: childAspectRatio,
                  ),
                  delegate: SliverChildBuilderDelegate((context, idx) {
                    final product = products[idx];
                    return BestsellerCard(product: product);
                  }, childCount: products.length),
                ),

                /// 🔹 Promo Banner
                SliverToBoxAdapter(
                  child: const PromoBottomCard(
        message: "Har zaroorat,\nBas kuch minute mein\ndelivered ❤️",
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

/// ---------------------------------------------------------------------------
/// 🔹 Sticky Search Bar Delegate
/// ---------------------------------------------------------------------------
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

/// ---------------------------------------------------------------------------
/// 🔹 Section Title
/// ---------------------------------------------------------------------------
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


/// ---------------------------------------------------------------------------
/// 🔹 Bestseller Card
/// ---------------------------------------------------------------------------
class BestsellerCard extends StatefulWidget {
  final Map<String, dynamic> product;

  const BestsellerCard({super.key, required this.product});

  @override
  State<BestsellerCard> createState() => _BestsellerCardState();
}

class _BestsellerCardState extends State<BestsellerCard> {
  bool isFavorite = false; // heart toggle state

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 🔹 Image + Wishlist + Bestseller Tag
          Container(
            height: 140.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: Colors.grey.withOpacity(0.6),
                width: 0.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Stack(
                children: [
                  /// Product Image
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/${widget.product["image"]}",
                      fit: BoxFit.contain,
                    ),
                  ),

                  /// Wishlist Heart (Top Right)
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact(); // vibration
                        setState(() {
                          isFavorite = !isFavorite; // toggle heart
                        });
                      },
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border, // filled/empty heart
                        color: Colors.red,
                        size: 18.sp,
                      ),
                    ),
                  ),

                  /// Bestseller Tag (Top Left)
                  Positioned(
                    top: 6.h,
                    left: 6.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
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

          /// 🔹 Content Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Price Row
                Row(
                  children: [
                    Text(
                      "₹${widget.product['discountPrice']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    if (widget.product["price"] !=
                        widget.product["discountPrice"])
                      Text(
                        "₹${widget.product['price']}",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppsColors.textclourgray,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),

                /// Quantity
                Text(
                  widget.product['quantity'],
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppsColors.textclourgray,
                  ),
                ),
                SizedBox(height: 4.h),

                /// Save Amount
                if (widget.product["saveAmount"] != null &&
                    widget.product["saveAmount"] > 0)
                  Text(
                    "SAVE ₹${widget.product["saveAmount"]}",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppsColors.savetextclour,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                SizedBox(height: 4.h),

                /// Product Name
                Text(
                  widget.product['productName'],
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12.sp),
                ),
                SizedBox(height: 6.h),

                /// Rating + Reviews
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.green, size: 16.sp),
                    SizedBox(width: 3.w),
                    Text(
                      widget.product['rating'].toString(),
                      style: TextStyle(fontSize: 12.sp, color: Colors.green),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "(${widget.product['reviews']})",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppsColors.textclourgray,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),

                /// Delivery Time
                Text(
                  widget.product['time'],
                  style: TextStyle(
                    color: AppsColors.textclourgray,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
