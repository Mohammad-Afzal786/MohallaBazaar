import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/core/constants/app_images.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';

import '../../presentation/widgets/bottomfootercard.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<Map<String, dynamic>> products = []; // Empty for demo

  /// Rotating Search Items
  final List<String> searchItems = [
    "Headphones",
    "Sneakers",
    "Smart Watch",
    "T-Shirts",
  ];

  int _currentIndex = 0;
  Timer? _hintTimer;

  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    _hintTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!_isSearching) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % searchItems.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final itemHeight = 300.h;
    final totalHorizontalPadding = 20.w;
    final crossAxisSpacing = 8.w;
    final itemWidth =
        (screenWidth - totalHorizontalPadding - crossAxisSpacing) / 2;
    final childAspectRatio = itemWidth / itemHeight;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          NavHelper.backFromwishlist();
        }
      },
      child: Scaffold(
        
        backgroundColor: Colors.white,
        body: 
        Column(
          children: [
             /// 🔹 Status bar padding
            Container(
              height: MediaQuery.of(context).padding.top,
              color: AppsColors.primary,
            ),
            
            /// 🔹 Main Content
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
                        children: [
                          /// Back Button
                          GestureDetector(
                            onTap: () => NavHelper.backFromwishlist(),
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

                          /// App name
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
                                        style: TextStyle(
                                          fontFamily: 'Geometry',
                                        ),
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
SliverToBoxAdapter(child: 
   Padding(
          padding: EdgeInsets.all(8.w),
          child: products.isEmpty
              ? _buildEmptyWishlist()
              : CustomScrollView(
                  slivers: [
                    _buildSearchBar(),
                    SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                    // Product Grid
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: crossAxisSpacing,
                        childAspectRatio: childAspectRatio,
                      ),
                      delegate: SliverChildBuilderDelegate((context, idx) {
                        final product = products[idx];
                        return SizedBox(
                          height: itemHeight,
                          child: Column(
                            children: [
                              // ... clone your product grid here ...
                            ],
                          ),
                        );
                      }, childCount: products.length),
                    ),
                  ],
                ),
        ),
     
     )
                  
       ,         

      
                  /// Promo Card
                  SliverToBoxAdapter(
                    child: PromoBottomCard(
                      message:
                          "Har zaroorat,\nBas kuch minute mein\ndelivered",
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 30.h)),
                ],
              ),
            ),
         
          ],
        )










        
     
      ),
    );
  }

  /// ===== EMPTY WISHLIST WIDGET =====
  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Your custom illustration image can be added here using Image.asset or a network image
          SizedBox(
            height: 280.h,
            width: double.infinity,
            child: Image.asset(
              AppImages.wishlistempty,
              fit: BoxFit.contain,
            ), // Replace with your empty icon asset
          ),
          SizedBox(height: 24.h),
          Text(
            "Your Wishlist is empty",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              "Start saving items you'd like to buy later, and they'll show up here",
              style: TextStyle(fontSize: 15.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
         
        ],
      ),
    );
  }

  /// ===== SEARCH BAR WIDGET =====
  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSearching = true;
          });
        },
        child: Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(anim),
                child: child,
              ),
            ),
            child: _isSearching
                ? TextField(
                    key: const ValueKey("textField"),
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Type to search...",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _isSearching = false;
                            _searchController.clear();
                          });
                        },
                      ),
                    ),
                  )
                : Row(
                    key: const ValueKey("idle"),
                    children: [
                      Icon(Icons.search, color: Colors.grey[600]),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Search ",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14.sp,
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder: (child, anim) {
                                return SlideTransition(
                                  position:
                                      Tween<Offset>(
                                        begin: const Offset(0, 1),
                                        end: const Offset(0, 0),
                                      ).animate(
                                        CurvedAnimation(
                                          parent: anim,
                                          curve: Curves.easeOut,
                                        ),
                                      ),
                                  child: FadeTransition(
                                    opacity: anim,
                                    child: child,
                                  ),
                                );
                              },
                              child: Text(
                                searchItems[_currentIndex],
                                key: ValueKey(_currentIndex),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
