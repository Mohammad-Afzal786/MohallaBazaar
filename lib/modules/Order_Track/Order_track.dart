import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mohalla_bazaar/core/storage/storage_helper.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/modules/Order_Track/order_tracking_api.dart';

class OrderTrack extends StatefulWidget {
  const OrderTrack({super.key});

  @override
  State<OrderTrack> createState() => _OrderTrackState();
}

class _OrderTrackState extends State<OrderTrack> {
  Map<String, dynamic>? orderDetails;
  bool isLoading = true;

  final steps = [
    {"title": "Order Placed", "subtitle": "We have received your order", "icon": Icons.shopping_cart},
    {"title": "Packed", "subtitle": "Your items are being packed", "icon": Icons.inventory},
    {"title": "Out for Delivery", "subtitle": "Our delivery partner is on the way", "icon": Icons.delivery_dining},
    {"title": "Delivered", "subtitle": "Order delivered successfully", "icon": Icons.check_circle},
  ];

  @override
  void initState() {
    super.initState();
    fetchOrderDetails(); // API call on page load

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  Future<void> fetchOrderDetails() async {
    final trackOrderId = StorageHelper().readOrderIdForTrack();
    if (trackOrderId == null) {
      setState(() {
        isLoading = false;
        orderDetails = null;
      });
      return;
    }

    final orderApi = OrderApi();
    final data = await orderApi.trackOrder(trackOrderId);

    setState(() {
      orderDetails = data;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    StorageHelper().clearOrderIdForTrack();
    super.dispose();
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(8, (_) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                height: 20.h,
                width: double.infinity,
                color: Colors.white,
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   final isCanceled = orderDetails != null && orderDetails!['currentStep'] == -1;

final progressValue = orderDetails == null
    ? 0.0
    : isCanceled
        ? 0.0
        : (orderDetails!['currentStep'] as int) > 3
            ? 1.0
            : (orderDetails!['currentStep'] as int) / 3.0;


    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) Get.back();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: AppsColors.primary,
            ),
            Container(
              color: AppsColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
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
                                  color: Colors.white,
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
            Expanded(
              child: isLoading
                  ? buildShimmer()
                  : orderDetails == null
                      ? const Center(child: Text("Failed to load order details"))
                      : SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.all(8.w),
                          child: Column(
                            children: [
                              // Order Summary
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order ID: ${orderDetails!['orderId']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      "Placed on: ${orderDetails!['createdAt'] != null ? DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(orderDetails!['createdAt']).toLocal()) : ''}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      "Amount: ₹ ${orderDetails!['grandTotal']}",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppsColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),

                              // ETA Progress
                              Container(
                                padding: EdgeInsets.all(14.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isCanceled ? "Order Canceled ❌" : "Estimated Delivery",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    if (!isCanceled)
                                      Text(
                                        orderDetails!['currentStep'] == 3
                                            ? "🎉 Your order has been delivered!"
                                            : orderDetails!['currentStep'] == 2
                                                ? "🚚 Out for delivery, arriving soon"
                                                : orderDetails!['currentStep'] == 1
                                                    ? "📦 Your items are being packed"
                                                    : "🛒 Order received, getting ready",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: orderDetails!['currentStep'] == 3
                                              ? AppsColors.primary
                                              : Colors.grey[700],
                                          fontWeight: orderDetails!['currentStep'] == 3
                                              ? FontWeight.bold
                                              : FontWeight.w500,
                                        ),
                                      ),
                                    SizedBox(height: 12.h),
                                    LinearProgressIndicator(
                                      value: progressValue,
                                      color: isCanceled ? Colors.red : AppsColors.primary,
                                      backgroundColor: Colors.grey.shade200,
                                      minHeight: 6,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.h),

                              // Timeline Steps
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: List.generate(steps.length, (index) {
                                    bool isCompleted = index <= (isCanceled ? -1 : orderDetails!['currentStep']);
                                    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: 28.w,
                                              height: 28.w,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: isCompleted ? AppsColors.primary : Colors.grey.shade300,
                                              ),
                                              child: Icon(
                                                steps[index]["icon"] as IconData,
                                                size: 16.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                            if (index != steps.length - 1)
                                              Container(
                                                width: 2,
                                                height: 50.h,
                                                color: isCompleted ? AppsColors.primary : Colors.grey.shade300,
                                              ),
                                          ],
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 4.h),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  steps[index]["title"] as String,
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: isCompleted ? Colors.black87 : Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  steps[index]["subtitle"] as String,
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(height: 20.h),

                              // Bottom Button
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    color: AppsColors.primary,
                                    size: 28.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: Text(
                                      orderDetails!['currentStep'] == 3
                                          ? "Order Delivered Successfully 🎉"
                                          : isCanceled
                                              ? "Order Canceled ❌"
                                              : "Your order is on the way 🚚",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (orderDetails!['currentStep'] == 3) {
                                        print("Rate Order tapped");
                                      } else {
                                        print("Track Live tapped");
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                                      decoration: BoxDecoration(
                                        color: AppsColors.primary,
                                        borderRadius: BorderRadius.circular(12.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppsColors.primary.withOpacity(0.4),
                                            blurRadius: 6,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        orderDetails!['currentStep'] == 3
                                            ? "Rate Order"
                                            : "Please wait...",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
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
