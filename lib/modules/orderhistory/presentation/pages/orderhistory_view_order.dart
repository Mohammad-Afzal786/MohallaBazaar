import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/core/storage/storage_helper.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/pages/cart.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/widgets/handlinginfo.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/widgets/showDeliveryFeeBreakup.dart';
import '../../domain/entities/orderhistory_entity.dart';

class OrderhistoryViewOrder extends StatefulWidget {
  final OrderEntity order;
  const OrderhistoryViewOrder({super.key, required this.order});

  @override
  State<OrderhistoryViewOrder> createState() => _OrderhistoryViewOrderState();
}

class _OrderhistoryViewOrderState extends State<OrderhistoryViewOrder> {
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
    final order = widget.order;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppsColors.primary,
        title: Text(
          "Order #${order.orderId}",
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
          onPressed: Get.back,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Status: ${order.status}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      "Estimated Time: ${order.estimatedDelivery}",
                      style: TextStyle(
                        color: AppsColors.textclourgray,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.6),
                      width: 0.5,
                    ),
                  ),
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
                              color: AppsColors.primary,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'From Our Store to Your Door — Fast & Easy!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppsColors.primary,
                                  ),
                                ),
                                Text(
                                  'Shipped of ${order.cartItemCount} items',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey.shade300, thickness: 0.2),
                      SizedBox(height: 5.h),
                      // Items List
                      ...order.items.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final item = entry.value;
                        final isLast = idx == order.items.length - 1;
                        return Column(
                          children: [
                            _buildOrderItem(item),
                            if (!isLast)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: Divider(
                                  height: 1.h,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                          ],
                        );
                      }),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                _buildBillDetails(order, context),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await StorageHelper().saveOrderIdForTrack(order.orderId);
                      NavHelper.goToOrdertrack();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppsColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Track Order",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(item) {
    return Container(
      margin: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SmartCachedImage(
              imageUrl: item.productImage,
              width: 50.w,
              height: 70.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Qty: ${item.productquantity}",
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹${item.discountPrice}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
              Text(
                "₹${item.price}",
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
    );
  }

  Widget _buildBillDetails(order, BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bill Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            _billRow(
              icon: Icons.receipt_long,
              label: "Items Total",
              trailing: [
                _savedBox(order.totalSaveAmount),
                SizedBox(width: 6.w),
                Text(
                  '₹${order.totalCartProductsAmount}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  '₹${order.totalCartDiscountAmount}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => HandlingChargeDialog.show(context),
              child: _billRow(
                icon: Icons.shopping_bag,
                label: "Handling Charge",
                trailing: [
                  Text(
                    "₹${order.handlingCharge}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                addLine: true,
              ),
            ),
            SizedBox(height: 6.h),
            GestureDetector(
              onTap: () => DeliveryFeeBreakupDialog.show(context),
              child: _billRow(
                icon: Icons.delivery_dining,
                label: "Delivery Charge",
                trailing: [
                  Text(
                    "₹${order.deliveryCharge}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                subtitle: order.totalCartProductsAmount >= 99
                    ? "🎉 You’ve unlocked Free Delivery"
                    : "Delivery charge: ₹30 (orders above ₹99 get free delivery)",
                subColor: const Color(0xFFF0872A),
                addLine: true,
              ),
            ),
            SizedBox(height: 12.h),
            Divider(color: Colors.grey.shade400, thickness: 1.h),
            SizedBox(height: 6.h),
            Row(
              children: [
                Text(
                  "Grand Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Spacer(),
                Text(
                  "₹${order.grandTotal}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _billRow({
    required IconData icon,
    required String label,
    List<Widget>? trailing,
    String? subtitle,
    Color? subColor,
    bool addLine = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.black87, size: 16.sp),
        SizedBox(width: 6.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12.sp, color: Colors.black87),
              ),
              if (addLine)
                SizedBox(
                  width: 110.w,
                  child: const DashedDivider(color: Colors.black, height: 1),
                ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: subColor ?? Colors.orange,
                  ),
                ),
            ],
          ),
        ),
        if (trailing != null) ...trailing,
      ],
    );
  }

  Widget _savedBox(num amount) => Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F1FF),
      borderRadius: BorderRadius.circular(5.r),
    ),
    child: Text(
      'Saved ₹$amount',
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF3889E5),
      ),
    ),
  );
}
