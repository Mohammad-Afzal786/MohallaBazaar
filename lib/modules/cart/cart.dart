import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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

  int? _selectedIndex;

  final List<Map<String, String>> tips = [
    {"label": "₹20", "emoji": "😁"},
    {"label": "₹30", "emoji": "😍"},
    {"label": "₹50", "emoji": "😇"},
  ];
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();

    
    final crossAxisSpacing = 8.w;

    
    int quantity = 1;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppsColors.primary,
          ),
          // Status bar padding + Header
          Container(
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
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.6),
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Delivery Info
                          Row(
                            children: [
                              Container(
                                width: 32.w,
                                height: 32.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDAF7E8),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.green,
                                  size: 22.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Free Delivery in 15 minutes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Shipped of 2 items',
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey.shade300, thickness: 0.2),
                          SizedBox(height: 16.h),

                          // Product Line
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.asset(
                                  'assets/images/image 31.png',
                                  width: 48.w,
                                  height: 48.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              // Name + Quantity
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fresh Onion',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      '1 Pack / 900 -1000 gm',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              // Stepper
                              Container(
                                height: 32.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: AppsColors.primary,
                                  border: Border.all(color: Colors.green),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: quantity > 1
                                          ? () => setState(() => quantity--)
                                          : null,
                                      icon: Icon(
                                        Icons.remove,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      constraints: BoxConstraints(
                                        maxHeight: 28.h,
                                      ),
                                    ),
                                    Text(
                                      '$quantity',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: quantity < 10
                                          ? () => setState(() => quantity++)
                                          : null,
                                      icon: Icon(
                                        Icons.add,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      constraints: BoxConstraints(
                                        maxHeight: 28.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 10.w),
                              // Price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₹22',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    '₹45',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey.shade300, thickness: 0.8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.asset(
                                  'assets/images/image 31.png',
                                  width: 48.w,
                                  height: 48.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              // Name + Quantity
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fresh Onion',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      '1 Pack / 900 -1000 gm',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              // Stepper
                              Container(
                                height: 32.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: AppsColors.primary,
                                  border: Border.all(color: Colors.green),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: quantity > 1
                                          ? () => setState(() => quantity--)
                                          : null,
                                      icon: Icon(
                                        Icons.remove,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      constraints: BoxConstraints(
                                        maxHeight: 28.h,
                                      ),
                                    ),
                                    Text(
                                      '$quantity',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: quantity < 10
                                          ? () => setState(() => quantity++)
                                          : null,
                                      icon: Icon(
                                        Icons.add,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      constraints: BoxConstraints(
                                        maxHeight: 28.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 10.w),
                              // Price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₹22',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    '₹45',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Divider(color: Colors.grey.shade300, thickness: 0.8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.asset(
                                  'assets/images/image 31.png',
                                  width: 48.w,
                                  height: 48.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              // Name + Quantity
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fresh Onion',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      '1 Pack / 900 -1000 gm',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              // Stepper
                              Container(
                                height: 32.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: AppsColors.primary,
                                  border: Border.all(color: Colors.green),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: quantity > 1
                                          ? () => setState(() => quantity--)
                                          : null,
                                      icon: Icon(
                                        Icons.remove,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      constraints: BoxConstraints(
                                        maxHeight: 28.h,
                                      ),
                                    ),
                                    Text(
                                      '$quantity',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: quantity < 10
                                          ? () => setState(() => quantity++)
                                          : null,
                                      icon: Icon(
                                        Icons.add,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      constraints: BoxConstraints(
                                        maxHeight: 28.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 10.w),
                              // Price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₹22',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    '₹45',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey.shade300, thickness: 0.8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.asset(
                                  'assets/images/image 31.png',
                                  width: 48.w,
                                  height: 48.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 14.w),
                              // Name + Quantity
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fresh Onion',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      '1 Pack / 900 -1000 gm',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              // Stepper
                              Container(
                                height: 32.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  color: AppsColors.primary,
                                  border: Border.all(color: Colors.green),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: quantity > 1
                                          ? () => setState(() => quantity--)
                                          : null,
                                      icon: Icon(
                                        Icons.remove,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      constraints: BoxConstraints(
                                        maxHeight: 28.h,
                                      ),
                                    ),
                                    Text(
                                      '$quantity',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: quantity < 10
                                          ? () => setState(() => quantity++)
                                          : null,
                                      icon: Icon(
                                        Icons.add,
                                        size: 16.sp,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      constraints: BoxConstraints(
                                        maxHeight: 28.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 10.w),
                              // Price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₹22',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    '₹45',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          const DashedDivider(color: Colors.grey, height: 1),

                          SizedBox(height: 20.h),

                          // Missed Something + Add More Items
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Missed something?',
                                style: TextStyle(fontSize: 13.sp),
                              ),
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: AppsColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 8.h,
                                  ),
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                                label: Text(
                                  'Add More Items',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Missed Something + Add More Items
                        ],
                      ),
                    ),
                  ),

                  /// 🔹 Horizontal Scroll Products
                  ///                /// 🔹 Section Title
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    child: Align(
                      alignment:
                          Alignment.centerLeft, // 👈 हमेशा left align रहेगा
                      child: Text(
                        "Your Wishlist",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600, // थोड़ा smooth bold
                          color:
                              Colors.black87, // थोड़ा dark grey ताकि soft लगे
                        ),
                      ),
                    ),
                  ),

                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(products.length, (idx) {
                          final product = products[idx];
                          return Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: BestsellerCard(product: product),
                          );
                        }),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Padding(
                    padding: EdgeInsets.fromLTRB(6.w, 0.h, 12.w, 0.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.6),
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Title
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 10),
                            child: Align(
                              alignment: Alignment
                                  .centerLeft, // 👈 हमेशा left align रहेगा
                              child: Text(
                                "You might also like",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight:
                                      FontWeight.w600, // थोड़ा smooth bold
                                  color: Colors
                                      .black87, // थोड़ा dark grey ताकि soft लगे
                                ),
                              ),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap:
                                true, // height apne items ke hisaab se lega
                            physics:
                                NeverScrollableScrollPhysics(), // parent scroll ke andar
                            itemCount: products.length > 6
                                ? 6
                                : products.length, // ✅ max 6 items
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: crossAxisSpacing,
                                  childAspectRatio:
                                      0.48, // item ka height/width adjust
                                ),
                            itemBuilder: (context, idx) {
                              final product = products[idx];
                              return BestsellerCard1(product: product);
                            },
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,

                      height: 90,
                      child: Card(
                        elevation: 0,
                        color: const Color(0xFFFfffff), // Light background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(
                                    255,
                                    216,
                                    212,
                                    213,
                                  ).withOpacity(0.13),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  Icons.delivery_dining,
                                  color: Color(0xFF1963DB),
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Get FREE delivery",
                                      style: TextStyle(
                                        color: Color(0xFF1963DB),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),

                                    Text(
                                      "Add products worth ₹${17} more",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 9),
                                    LinearProgressIndicator(
                                      value: 0.6,
                                      backgroundColor: Color(0xFFE8EDFA),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF1963DB),
                                      ),
                                      minHeight: 4,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0xFFFfffff), // Exact background as image
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            Text(
                              "Bill details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 13),
                            // Items total row
                            Row(
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  color: Color(0xFF323743),
                                  size: 21,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Items total",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF23262F),
                                  ),
                                ),
                                SizedBox(width: 7),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE8F1FF),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 1.8,
                                  ),
                                  child: Text(
                                    "Saved ₹3",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF3889E5),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "₹60",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF677085),
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 2,
                                  ),
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "₹57",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF23262F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7),
                            // Handling charge row
                            GestureDetector(
                              onTap: () => _showHandlingInfo(
                                context,
                              ), // 👈 popup open karega
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    color: Color(0xFF323743),
                                    size: 21,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Handling charge",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF23262F),
                                          ),
                                        ),
                                        SizedBox(height: 1),
                                        SizedBox(
                                          width: 110,
                                          child: const DashedDivider(
                                            color: Colors.black,
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 6,
                                      right: 10,
                                      top: 9,
                                    ),
                                    child: Divider(
                                      color: Color(0xFFB6BBC4),
                                      thickness: 1,
                                      height: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Text(
                                      "₹5",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF23262F),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            // Delivery charge row
                            GestureDetector(
                              onTap: () => _showDeliveryFeeBreakup(
                                context,
                              ), // 👈 popup open karega
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    color: Color(0xFF323743),
                                    size: 21,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Delivery charge",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF23262F),
                                          ),
                                        ),
                                        SizedBox(height: 1),
                                        SizedBox(
                                          width: 110,
                                          child: const DashedDivider(
                                            color: Colors.black,
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          "Shop for ₹42 more to get FREE delivery",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFFF0872A),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 6,
                                      right: 10,
                                      top: 9,
                                    ),
                                    child: Divider(
                                      color: Color(0xFFB6BBC4),
                                      thickness: 1,
                                      height: 18,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Text(
                                      "₹25",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF23262F),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Divider(
                              color: Color(0xFFB6BBC4),
                              thickness: 1,
                              height: 2,
                            ),
                            SizedBox(height: 7),
                            // Grand total row
                            Row(
                              children: [
                                Text(
                                  "Grand total",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "₹84",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0xFFFfffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tip your delivery partner",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Your kindness means a lot! 100% of your tip will go directly to your delivery partner.",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF23262F),
                              ),
                            ),
                            SizedBox(height: 15),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(tips.length, (index) {
                                  final isSelected = _selectedIndex == index;
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: index != tips.length - 1 ? 8 : 0,
                                    ),
                                    child: ChoiceChip(
                                      selected: isSelected,
                                      showCheckmark: false,
                                      onSelected: (_) {
                                        setState(() {
                                          _selectedIndex = index;
                                        });
                                        // Tumhara custom onTipSelect logic yahan daal sakte ho
                                      },
                                      label: Row(
                                        children: [
                                          Text(
                                            tips[index]["emoji"]!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            tips[index]["label"]!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: isSelected
                                                  ? Colors.white
                                                  : Color(0xFF23262F),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: Colors.white,
                                      selectedColor: Color(0xFF2BC46A),
                                      side: BorderSide(
                                        color: isSelected
                                            ? Color(0xFF2BC46A)
                                            : Color(0xFFD0D6DE),
                                        width: 1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(26),
                                      ),
                                      labelPadding: EdgeInsets.symmetric(
                                        horizontal: 11,
                                        vertical: 4,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0xFFffffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cancellation Policy",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.5,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Orders cannot be cancelled once packed for delivery. In case of unexpected delays, a refund will be provided, if applicable.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF23262F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Address Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: AppsColors.primary,
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Deliver',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Spacer(),

                                        Text(
                                          'Change',
                                          style: TextStyle(
                                            color: AppsColors.primary,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Gg, R Batla House, Jamia Nagar, Okhla, New...',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          // Divider
                          Divider(height: 1, color: Colors.grey[300]),
                          SizedBox(height: 12),
                          // Total Price & Pay Button
                          SizedBox(
                            width: double.infinity,
                            height: 52.h,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppsColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 2,
                              ),
                              child: Text(
                                'Order now',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
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
          ),
        ],
      ),
    );
  }
}

class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;

  const DashedDivider({super.key, this.height = 0.2, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(color: color, height: height),
      size: Size(double.infinity, height),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double height;
  final Color color;

  _DashedLinePainter({required this.height, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    const dashWidth = 4.0;
    const dashSpace = 3.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

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
      width: 140.w, // fixed width for horizontal scroll
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Image + Wishlist + Bestseller Tag
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
                child: Image.asset(
                  "assets/images/${widget.product["image"]}",
                  height: 100.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),

              /// Bestseller Tag (Top Left)
              Positioned(
                top: 6.h,
                left: 6.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    "Bestseller",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              /// Wishlist Heart (Top Right)
              Positioned(
                top: 6.h,
                right: 6.w,
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    setState(() => isFavorite = !isFavorite);
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),

          /// 🔹 Content
          Padding(
            padding: EdgeInsets.all(6.w),
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
                    SizedBox(width: 4.w),
                    if (widget.product["price"] !=
                        widget.product["discountPrice"])
                      Text(
                        "₹${widget.product['price']}",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppsColors.textclourgray,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 3.h),

                /// Product Name
                Text(
                  widget.product['productName'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.sp),
                ),

                SizedBox(height: 3.h),

                /// Rating
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.green, size: 12.sp),
                    SizedBox(width: 3.w),
                    Text(
                      widget.product['rating'].toString(),
                      style: TextStyle(fontSize: 10.sp, color: Colors.green),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),

                /// Delivery Time
                Text(
                  widget.product['time'],
                  style: TextStyle(
                    color: AppsColors.textclourgray,
                    fontSize: 9.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BestsellerCard1 extends StatefulWidget {
  final Map<String, dynamic> product;

  const BestsellerCard1({super.key, required this.product});

  @override
  State<BestsellerCard1> createState() => _BestsellerCard1State();
}

class _BestsellerCard1State extends State<BestsellerCard1> {
  bool isFavorite = false; // heart toggle state

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 🔹 Image + Wishlist + Bestseller Tag
          Container(
            height: 120.h,
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
                      onTap: () async {
                        if (await Vibrate.canVibrate) {
                          Vibrate.feedback(FeedbackType.success);
                        }
                        setState(() {
                          isFavorite = !isFavorite;
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
                  maxLines: 2,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showHandlingInfo(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    barrierColor: Colors.black54,
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Handling charge",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "For proper handling and ensuring high quality quick-deliveries",
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 0.55,
                  height: 1,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Center(
                    child: Text(
                      "Sounds good",
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeIn,
        ),
        child: child,
      );
    },
  );
}

void _showDeliveryFeeBreakup(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    barrierColor: Colors.black54,
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading row
                Row(
                  children: [
                    Text(
                      "Delivery Fee Breakup",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.8,
                        color: Color(0xFF23262F),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "₹30",
                      style: TextStyle(
                        fontSize: 15.8,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF23262F),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 11),
                Divider(color: Colors.grey.shade300, thickness: 0.3),
                // Below Rs 99 row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "For orders below ₹99",
                        style: TextStyle(
                          color: Color(0xFF23262F),
                          fontSize: 14.4,
                        ),
                      ),
                    ),
                    Text(
                      "₹30",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.4,
                        color: Color(0xFF23262F),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7),
                // Above Rs 99 row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "For orders above ₹99",
                        style: TextStyle(
                          color: Color(0xFF23262F),
                          fontSize: 14.4,
                        ),
                      ),
                    ),
                    Text(
                      "FREE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.4,
                        color: Color(0xFF27A844), // Green bold
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeIn,
        ),
        child: child,
      );
    },
  );
}
