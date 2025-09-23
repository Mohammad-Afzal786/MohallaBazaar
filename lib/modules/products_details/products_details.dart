import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/entities/parent_categorydetails_entity.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/entities/product_entity.dart';

class ProductsDetails extends StatefulWidget {
  const ProductsDetails({super.key});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  final String title = 'Onion';
  // clicked product

  final String img1 =
      "https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1176-1176,pr-true,f-auto,q-80/cms/product_variant/5e44c2c3-8fa7-460f-8b1d-3fec37b77c1b/MAGGI-2-Minute-Instant-Noodles-Masala-Noodles-Made-With-Quality-Spices.jpeg";
  final String img2 =
      "https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1176-1176,pr-true,f-auto,q-80/cms/product_variant/7ee467c5-ae84-4387-9fb8-1dcdeb651f14/MAGGI-2-Minute-Instant-Noodles-Masala-Noodles-Made-With-Quality-Spices.jpeg";

  // List of image URLs for slider
  // final List<String> images = [
  //   'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1176-1176,pr-true,f-auto,q-80/cms/product_variant/5e44c2c3-8fa7-460f-8b1d-3fec37b77c1b/MAGGI-2-Minute-Instant-Noodles-Masala-Noodles-Made-With-Quality-Spices.jpeg',
  //   'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1176-1176,pr-true,f-auto,q-80/cms/product_variant/7ee467c5-ae84-4387-9fb8-1dcdeb651f14/MAGGI-2-Minute-Instant-Noodles-Masala-Noodles-Made-With-Quality-Spices.jpeg',
  //   'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1176-1176,pr-true,f-auto,q-80/cms/product_variant/5346adc4-ce65-4c74-9d15-393674092b72/MAGGI-2-Minute-Instant-Noodles-Masala-Noodles-Made-With-Quality-Spices.jpeg',
  //   'https://cdn.zeptonow.com/production/ik-seo/tr:w-470,ar-1176-1176,pr-true,f-auto,q-80/cms/product_variant/5e44c2c3-8fa7-460f-8b1d-3fec37b77c1b/MAGGI-2-Minute-Instant-Noodles-Masala-Noodles-Made-With-Quality-Spices.jpeg',
  // ];

  int qty = 1;
  bool isFavorite = false;

  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;

  // Current page index in slider
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    // Output: ProductEntity(name: Mango, price: 120.0, image: http://...)

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
    final box = GetStorage();

    // 1️⃣ Pehla product
    final productslistfromcategorydetailspage = box.read(
      'productslistfromcategorydetailspage',
    );
    ProductEntity? productfromcategorydetails;
    if (productslistfromcategorydetailspage != null) {
      productfromcategorydetails = ProductEntity.fromJson(
        Map<String, dynamic>.from(productslistfromcategorydetailspage),
      );
    }

    // 2️⃣ Dusra product
    final productslistfromparentcategorydetailspage = box.read(
      'productslistfromparentcategorydetailspage',
    );
    ProductEntity? productfromparentcategorydetails;
    if (productslistfromparentcategorydetailspage != null) {
      productfromparentcategorydetails = ProductEntity.fromJson(
        Map<String, dynamic>.from(productslistfromparentcategorydetailspage),
      );
    }

    // 3️⃣ Merge only non-null products
    final merged = [
      if (productfromcategorydetails != null) productfromcategorydetails,
      if (productfromparentcategorydetails != null)
        productfromparentcategorydetails,
    ];

    if (merged.isEmpty) {
      return const Center(child: Text("No products available"));
    }

    // 4️⃣ Use merged list
    final productToShow = merged.first; // example: first product

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final List<String> images = [img1, img2];
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) NavHelper.backToprducsdetails();
        box.remove('productslistfromcategorydetailspage');
        box.remove('productslistfromparentcategorydetailspage');
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
                              child: SmartCachedImage(
                                imageUrl: images[index],
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
                          Expanded(
                            // 👈 isse width constraint milega
                            child: Text(
                              productToShow.productName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
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
                        "Net Qty : ${productToShow.productquantity}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            productToShow.productdiscountPrice.toString(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${calculateDiscountPercent(productToShow.productprice, productToShow.productdiscountPrice).toStringAsFixed(0)}% OFF",

                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: productToShow.productprice.toString(),
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
                          children: [
                            Icon(
                              Icons.flash_on,
                              color: Color(0xff014E20),
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Estimated Delivery Time: ${productToShow.producttime}",
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
                      onTap: () {
                        box.remove('productslistfromcategorydetailspage');
                        box.remove('productslistfromparentcategorydetailspage');
                        NavHelper.backToprducsdetails();
                      },
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
                    Opacity(
                      opacity: _appBarOpacity,
                      child: Container(
                        width: 35.w,
                        height: 35.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: SmartCachedImage(
                            imageUrl: productToShow.productimage,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10),
                    Expanded(
                      child: Opacity(
                        opacity: _appBarOpacity,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productToShow.productName,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${calculateDiscountPercent(productToShow.productprice, productToShow.productdiscountPrice).toStringAsFixed(0)}% OFF",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                    // 1️⃣ View Cart Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          box.remove('productslistfromcategorydetailspage');
                          box.remove(
                            'productslistfromparentcategorydetailspage',
                          );
                          NavHelper.goToCartFromProductsDetails();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "View Cart",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // 2️⃣ Add to Cart Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add to cart logic here
                          print("Product added to cart");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEC407A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
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

double calculateDiscountPercent(num price, num discountPrice) {
  double originalPrice = price.toDouble();
  double discounted = discountPrice.toDouble();

  if (originalPrice <= 0) return 0; // divide by zero se bachne ke liye
  double discount = originalPrice - discounted;
  return (discount / originalPrice) * 100;
}
