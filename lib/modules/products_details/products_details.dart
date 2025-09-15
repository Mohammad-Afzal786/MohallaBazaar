import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/config/routes.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';

class ProductsDetails extends StatefulWidget {
  const ProductsDetails({super.key});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  final String title = 'Onion';

  // List of image URLs for slider
  final List<String> images = [
    'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1176-1176,pr-true,f-auto,q-80/cms/product_variant/5e44c2c3-8fa7-460f-8b1d-3fec37b77c1b/MAGGI-2-Minute-Instant-Noodles-Masala-Noodles-Made-With-Quality-Spices.jpeg',
    'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1176-1176,pr-true,f-auto,q-80/cms/product_variant/7ee467c5-ae84-4387-9fb8-1dcdeb651f14/MAGGI-2-Minute-Instant-Noodles-Masala-Noodles-Made-With-Quality-Spices.jpeg',
    'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1176-1176,pr-true,f-auto,q-80/cms/product_variant/5346adc4-ce65-4c74-9d15-393674092b72/MAGGI-2-Minute-Instant-Noodles-Masala-Noodles-Made-With-Quality-Spices.jpeg',
    'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1176-1176,pr-true,f-auto,q-80/cms/product_variant/5e44c2c3-8fa7-460f-8b1d-3fec37b77c1b/MAGGI-2-Minute-Instant-Noodles-Masala-Noodles-Made-With-Quality-Spices.jpeg',
  ];

  int qty = 1;
  bool isFavorite = false;

  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;

  // Current page index in slider
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double newOpacity = (offset / 200).clamp(0, 1);
      if (newOpacity != _appBarOpacity) {
        setState(() {
          _appBarOpacity = newOpacity;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) NavHelper.backToprducsdetails();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            // Scrollable content with image slider & details
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 300 + statusBarHeight,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        // Image slider with PageView
                        PageView.builder(
                          itemCount: images.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return InteractiveViewer(
                              maxScale: 4.0, // maximum zoom scale
                              minScale:
                                  1.0, // minimum zoom scale (original size)
                              child: Image.network(
                                images[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            );
                          },
                        ),

                        // Gradient overlay on top for status bar area
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          height: statusBarHeight + kToolbarHeight,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black54, Colors.transparent],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),

                        // Page indicators at bottom center inside image area
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(images.length, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                width: _currentImageIndex == index ? 18 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentImageIndex == index
                                      ? AppsColors.primary
                                      : const Color.fromARGB(255, 73, 72, 72),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Rest of your Sliver content unchanged
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Row(
                        children: [
                          const Text("Onion", style: TextStyle(fontSize: 20)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              HapticFeedback.selectionClick();
                              setState(() => isFavorite = !isFavorite);
                            },
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: 25.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Net Qty: 1 Pack (900 - 1000 Gm)",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Text(
                            "₹26",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "43% Off",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "₹46",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: " MRP (incl. of all taxes)",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.white,
                              Color.fromARGB(255, 214, 248, 236),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.flash_on,
                              color: Color(0xff014E20),
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Estimated Delivery Time: 23 mins",
                              style: TextStyle(color: Color(0xff014E20)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9FB),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.not_interested,
                                      size: 28,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "No Return Or Exchange",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9FB),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.delivery_dining,
                                      size: 28,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Fast Delivery",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Highlights",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          children: [
                            Expanded(child: Text("Brand")),
                            Expanded(child: Text("Unbranded")),
                          ],
                        ),
                      ),
                      const SizedBox(height: 120),
                    ]),
                  ),
                ),
              ],
            ),

            // Custom app bar overlay
            Container(
              height: statusBarHeight + kToolbarHeight,
              padding: EdgeInsets.only(top: statusBarHeight),
              color: AppsColors.primary.withOpacity(_appBarOpacity),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    /// Back Button
                    GestureDetector(
                      onTap: () => NavHelper.backToprducsdetails(),
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

                    SizedBox(width: 10),
                    Expanded(
                      child: Opacity(
                        opacity: _appBarOpacity,
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom cart bar fixed at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    // View Cart Button
                    InkWell(
                      onTap: () {
                        NavHelper.goToCartFromProductsDetails();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 22,
                                  color: Colors.black87,
                                ),
                                Positioned(
                                  top: -10,
                                  right: -10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFFEC407A,
                                      ), // Pink badge
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Text(
                                      "9",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "View Cart",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Counter Button
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEC407A),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                              size: 24,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              setState(() {
                                if (qty > 1) qty--;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              qty.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 24,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              setState(() {
                                qty++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
