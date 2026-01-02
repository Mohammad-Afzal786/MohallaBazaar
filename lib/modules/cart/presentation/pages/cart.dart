import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/network/sqlite_client.dart';
import 'package:mohalla_bazaar/core/storage/storage_helper.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/Address_list/address_list.dart';
import 'package:mohalla_bazaar/modules/cart/domain/entities/cart_item_entity.dart';
import 'package:mohalla_bazaar/modules/cart/domain/entities/viewcart_entity.dart'
    hide CartItemEntity;
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_event.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_state.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_event.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_event.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_state.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/widgets/handlinginfo.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/widgets/showDeliveryFeeBreakup.dart';
import 'package:mohalla_bazaar/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mohalla_bazaar/modules/notification/presentation/pages/notification_page.dart';
import 'package:mohalla_bazaar/modules/order_now/presentation/bloc/order_bloc.dart';
import 'package:mohalla_bazaar/modules/order_now/presentation/bloc/order_event.dart';
import 'package:mohalla_bazaar/modules/order_now/presentation/bloc/order_state.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _dialogShown = false;
  Map<String, dynamic>? selectedAddress;
  @override
  void initState() {
    super.initState();
    loadSelectedAddress();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    final box = GetStorage();
    final userid = box.read("userid");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ViewCartBloc>().add(LoadViewCart(userId: userid));
    });
  }

  @override
  void dispose() {
    _dialogShown = false;
    super.dispose();
  }

  void loadSelectedAddress() async {
    var address = await SQLiteClient.getSelectedAddress();
    if (!mounted) return; // prevent calling setState after dispose
    setState(() {
      selectedAddress = address;
    });
  }

  // ✅ Cart warning dialog

  Future<void> _showCartWarningDialog({
    required int cartTotal,
    required int minDeliveryAmount,
    required String username,
  }) async {
    // 🧠 Open only if not shown and below min amount
    if (_dialogShown || cartTotal <= 0 || cartTotal >= minDeliveryAmount) {
      return;
    }

    _dialogShown = true;

    try {
      if (!mounted) return;

      // Close any open dialogs first (optional safety)
      if (Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      final screenWidth = MediaQuery.of(context).size.width;

      // 🧩 Show only one dialog and await till closed
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          if (!mounted) return const SizedBox();

          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: screenWidth,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "थोड़ा और खरीदिए! 🌾",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "$username जी, अभी आपका बिल ₹$minDeliveryAmount से कम है, इसलिए ₹25 डिलीवरी चार्ज लग सकता है। "
                      "बस ₹${(minDeliveryAmount - cartTotal)} का और सामान जोड़ लीजिए,\n"
                      "मोहल्ला बाज़ार ₹99 से ज़्यादा की खरीद पर डिलीवरी फ्री देता है! 🚚",
                      style: TextStyle(fontSize: 18.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: 0.8.sw,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (mounted) {
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppsColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          "मैंने समझ लिया",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint("⚠️ Dialog Error: $e");
    } finally {
      // 🔒 Reset only after dialog actually closes
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _dialogShown = false;
        });
      } else {
        _dialogShown = false;
      }
    }
  }

  // 👈 state variable add karo
  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();
    final state = context.watch<ViewCartBloc>().state;
    final cart1 = state.cart;
    final bool isDisabled = cart1?.cartTotalAmount == 0;
    final box = GetStorage();
    final cartTotal = cart1?.cartTotalAmount ?? 0;
    final needamuttoreedelvery =  0;
    final username = box.read("username") ?? '';

    // ✅ Show dialog safely after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int itemCount = cart1?.cartItemCount ?? 0;

      // Only show if:
      // 1. mounted
      // 2. cart is not null
      // 3. at least 1 item in cart
      // 4. dialog not already shown
      if (mounted && cart1 != null && itemCount > 0 && !_dialogShown) {
        _showCartWarningDialog(
          cartTotal: cartTotal.toInt(),
          minDeliveryAmount: needamuttoreedelvery,
          username: username,
        );
      }
    });

    return ScreenUtilInit(
      designSize: const Size(393, 804),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) NavHelper.backToparentcategorydetails();
          },
          child: Scaffold(
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
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
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.access_time_rounded,
                                        color: AppsColors.primary,
                                        size: 22.sp,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Superfast Delivery at Your Doorstep',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                            color: AppsColors.primary,
                                          ),
                                        ),
                                        Text(
                                          'Shipped of ${cart1?.cartItemCount} items',

                                          style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 0.2,
                                ),

                                // Product Line
                                BlocBuilder<ViewCartBloc, ViewCartState>(
                                  builder: (context, state) {
                                    if (state.status ==
                                            ViewCartStatus.loading &&
                                        state.cart == null) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state.status ==
                                        ViewCartStatus.failure) {
                                      return Center(
                                        child: Text('Error: ${state.error}'),
                                      );
                                    } else if (state.cart == null) {
                                      return const Center(
                                        child: Text('No items in cart'),
                                      );
                                    } else {
                                      final cart = state.cart!;

                                      return ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(), // scroll parent ke liye
                                        shrinkWrap:
                                            true, // apni height ke hisaab se adjust
                                        itemCount: cart.cartList.length,
                                        padding: EdgeInsets
                                            .zero, // 🔹 Top gap remove
                                        separatorBuilder: (_, __) => Divider(
                                          color: Colors.grey.shade300,
                                          thickness: 0.8,
                                        ),
                                        itemBuilder: (context, index) {
                                          final item = cart.cartList[index];
                                          return _CartItemCard(
                                            imageUrl: item.productImage,
                                            name: item.productName,
                                            subtitle: item.productId,
                                            productsquanity:
                                                item.productQuantity,
                                            quantity: item.quantity,
                                            price: item.discountPrice,
                                            prodctid: item.productId,
                                            originalPrice: item.price,
                                            onIncrease: () {
                                              Get.snackbar("title", "message");
                                            },
                                            onDecrease: () {},
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),

                                SizedBox(height: 20.h),
                                const DashedDivider(
                                  color: Colors.grey,
                                  height: 1,
                                ),

                                SizedBox(height: 20.h),

                                // Missed Something + Add More Items
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Missed something?',
                                      style: TextStyle(fontSize: 13.sp),
                                    ),
                                    SizedBox(
                                      width: 0.35
                                          .sw, // 🔹 65% of screen width — balanced for dialog/buttons
                                      height:
                                          35.h, // 🔹 consistent button height
                                      child: TextButton.icon(
                                        style: TextButton.styleFrom(
                                          backgroundColor: AppsColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 8.h,
                                          ),
                                        ),
                                        onPressed: () {
                                          controller.changeTab(2);
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 16.sp, // ✅ responsive icon size
                                        ),
                                        label: Text(
                                          'Add More Items',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                12.sp, // ✅ responsive text
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          width: double.infinity,
                          height: 90.h, // ✅ responsive height
                          child: Card(
                            elevation: 0,
                            color: const Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 12.h,
                              ),
                              child: Row(
                                children: [
                                  // 🚚 Icon section
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFFD8D4D5,
                                      ).withOpacity(0.13),
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    padding: EdgeInsets.all(6.w),
                                    child: Icon(
                                      Icons.delivery_dining,
                                      color:
                                          (cart1?.needToAddForFreeDelivery ??
                                                  1) <=
                                              0
                                          ? AppsColors.primary
                                          : const Color(0xFF1963DB),
                                      size: 26.sp, // ✅ responsive icon size
                                    ),
                                  ),

                                  SizedBox(width: 10.w),

                                  // 📋 Text + Progress
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // 🏷 Title
                                        Text(
                                          (cart1?.needToAddForFreeDelivery ??
                                                      1) <=
                                                  0
                                              ? "🎉 Free Delivery"
                                              : "Get FREE delivery",
                                          style: TextStyle(
                                            color:
                                                (cart1?.needToAddForFreeDelivery ??
                                                        1) <=
                                                    0
                                                ? AppsColors.primary
                                                : const Color(0xFF1963DB),
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                13.sp, // ✅ responsive text
                                          ),
                                        ),

                                        SizedBox(height: 4.h),

                                        // 📦 Subtitle
                                        Text(
                                          (cart1?.needToAddForFreeDelivery ??
                                                      1) <=
                                                  0
                                              ? "You have unlocked free delivery"
                                              : "Add ₹${cart1?.needToAddForFreeDelivery ?? 0} more for FREE delivery",
                                          style: TextStyle(
                                            color: AppsColors.textclourgray,
                                            fontSize: 11.sp,
                                          ),
                                        ),

                                        SizedBox(height: 8.h),

                                        // 📊 Progress bar
                                        LinearProgressIndicator(
                                          value:
                                              (cart1?.needToAddForFreeDelivery ??
                                                      1) <=
                                                  0
                                              ? 1.0
                                              : ((cart1?.cartTotalAmount ?? 0) /
                                                        ((cart1?.cartTotalAmount ??
                                                                0) +
                                                            (cart1?.needToAddForFreeDelivery ??
                                                                1)))
                                                    .clamp(0.0, 1.0),
                                          backgroundColor: const Color(
                                            0xFFE8EDFA,
                                          ),
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                (cart1?.needToAddForFreeDelivery ??
                                                            1) <=
                                                        0
                                                    ? AppsColors.primary
                                                    : const Color(0xFF1963DB),
                                              ),
                                          minHeight:
                                              4.h, // ✅ responsive thickness
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 6.w),

                                  // ➡ Arrow
                                  Icon(
                                    Icons.chevron_right,
                                    color: AppsColors.textclourgray,
                                    size: 22.sp, // ✅ responsive icon
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Card(
                          color: const Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                          child: Padding(
                            padding: EdgeInsets.all(18.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 🧾 Heading
                                Text(
                                  "Bill details",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 13.h),

                                // 💰 Items total row
                                Row(
                                  children: [
                                    Icon(
                                      Icons.receipt_long,
                                      color: const Color(0xFF323743),
                                      size: 18.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "Items total",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF23262F),
                                      ),
                                    ),
                                    SizedBox(width: 7.w),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8F1FF),
                                        borderRadius: BorderRadius.circular(
                                          5.r,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 7.w,
                                        vertical: 2.h,
                                      ),
                                      child: Text(
                                        'Saved ₹${cart1?.totalSaveAmount ?? 0}',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: const Color(0xFF3889E5),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹ ${cart1?.totalCartProductsAmount ?? 0}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF677085),
                                        decoration: TextDecoration.lineThrough,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      '₹ ${cart1?.totalCartDiscountAmount ?? 0}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: const Color(0xFF23262F),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 8.h),

                                // 🧺 Handling charge row
                                GestureDetector(
                                  onTap: () =>
                                      HandlingChargeDialog.show(context),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag,
                                        color: const Color(0xFF323743),
                                        size: 18.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Handling charge",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: const Color(0xFF23262F),
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            SizedBox(
                                              width: 110.w,
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
                                          left: 6.w,
                                          right: 10.w,
                                          top: 9.h,
                                        ),
                                        child: Divider(
                                          color: const Color(0xFFB6BBC4),
                                          thickness: 1,
                                          height: 18.h,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: Text(
                                          "₹0",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: const Color(0xFF23262F),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 6.h),

                                // 🚚 Delivery charge row
                                GestureDetector(
                                  onTap: () =>
                                      DeliveryFeeBreakupDialog.show(context),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.delivery_dining,
                                        color: const Color(0xFF323743),
                                        size: 18.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Delivery charge",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: const Color(0xFF23262F),
                                              ),
                                            ),
                                            SizedBox(height: 2.h),
                                            SizedBox(
                                              width: 110.w,
                                              child: const DashedDivider(
                                                color: Colors.black,
                                                height: 1,
                                              ),
                                            ),
                                            SizedBox(height: 3.h),
                                            Text(
                                              (cart1?.needToAddForFreeDelivery ??
                                                          0) >
                                                      0
                                                  ? "Add ₹${cart1!.needToAddForFreeDelivery} more for Free Delivery"
                                                  : "🎉 You’ve unlocked Free Delivery",
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    (cart1?.needToAddForFreeDelivery ??
                                                            0) >
                                                        0
                                                    ? const Color(0xFFF0872A)
                                                    : Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 6.w,
                                          right: 10.w,
                                          top: 9.h,
                                        ),
                                        child: Divider(
                                          color: const Color(0xFFB6BBC4),
                                          thickness: 1,
                                          height: 18.h,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: Text(
                                          "₹${cart1?.deliveryCharge ?? 0}",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: const Color(0xFF23262F),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 12.h),
                                Divider(
                                  color: const Color(0xFFB6BBC4),
                                  thickness: 1,
                                  height: 2.h,
                                ),
                                SizedBox(height: 7.h),

                                // 💵 Grand total
                                Row(
                                  children: [
                                    Text(
                                      "Grand total",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "₹${cart1?.grandTotal ?? 0}",
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
                        ),

                        Card(
                          color: const Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 14.h,
                              horizontal: 12.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cancellation Policy",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "Orders cannot be cancelled once packed for delivery. In case of unexpected delays, a refund will be provided, if applicable.",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF23262F),
                                    height:
                                        1.4, // better readability across screens
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 14.h,
                              horizontal: 12.w,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // 🏠 Address Row
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 20.sp,
                                      color: AppsColors.primary,
                                    ),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Deliver',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          const AddressListPage(),
                                                    ),
                                                  );
                                                  loadSelectedAddress();
                                                },
                                                child: Text(
                                                  'Change',
                                                  style: TextStyle(
                                                    color: AppsColors.primary,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            selectedAddress != null
                                                ? '${selectedAddress!['title']}, ${selectedAddress!['detail']}'
                                                : 'No address selected',
                                            style: TextStyle(
                                              fontSize: 11.5.sp,
                                              color: Colors.grey[700],
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 14.h),
                                Divider(height: 1.h, color: Colors.grey[300]),
                                SizedBox(height: 10.h),

                                // 🛒 Order Button
                                BlocListener<OrderBloc, OrderState>(
                                  listener: (context, state) async {
                                    if (state is OrderFailure) {
                                      final errorMsg = state.message.isNotEmpty
                                          ? state.message
                                          : "Order failed";
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text(errorMsg)),
                                      );
                                    } else if (state is OrderSuccess) {
                                      final storage = StorageHelper();
                                      await storage.saveOrderId(
                                        state.order.orderId,
                                      );

                                      final box = GetStorage();
                                      final userid = box.read("userid");

                                      // 🔄 Refresh the cart and count
                                      // context.read<ViewCartBloc>().add(LoadViewCart(userId: userid));
                                      context.read<CartCountBloc>().add(
                                        LoadCartCount(userid),
                                      );

                                      await StorageHelper().saveOrderIdForTrack(
                                        state.order.orderId,
                                      );

                                      // 🧠 Fix: Wait for the above blocs to update UI before navigation
                                      await Future.delayed(
                                        const Duration(milliseconds: 300),
                                      );

                                      // 🔐 Ensure context is still valid before navigation
                                      if (context.mounted) {
                                        NavHelper.goToordersuccessfully();
                                      }
                                    }
                                  },
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 40.h,
                                    child: BlocBuilder<OrderBloc, OrderState>(
                                      builder: (context, state) {
                                        final isLoading = state is OrderLoading;
                                        final bool isAddressSelected =
                                            selectedAddress != null;

                                        return ElevatedButton(
                                          onPressed:
                                              (!isAddressSelected ||
                                                  isLoading ||
                                                  isDisabled)
                                              ? () async {
                                                  if (!isAddressSelected) {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            const AddressListPage(),
                                                      ),
                                                    );
                                                    loadSelectedAddress();
                                                  }
                                                }
                                              : () async {
                                                  final confirmed = await showCupertinoDialog<bool>(
                                                    context: context,
                                                    builder: (context) => CupertinoAlertDialog(
                                                      title: const Text(
                                                        "Confirm Order",
                                                      ),
                                                      content: Text(
                                                        (cart1 == null ||
                                                                (cart1.grandTotal ??
                                                                        0) ==
                                                                    0)
                                                            ? "Are you sure you want to place this order?"
                                                            : "Are you sure you want to place this order for ₹${cart1.grandTotal}?",
                                                      ),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                context,
                                                                false,
                                                              ),
                                                          isDestructiveAction:
                                                              true,
                                                          child: const Text(
                                                            "Cancel",
                                                          ),
                                                        ),
                                                        CupertinoDialogAction(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                context,
                                                                true,
                                                              ),
                                                          isDefaultAction: true,
                                                          child: const Text(
                                                            "Confirm",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );

                                                  if (confirmed == true) {
                                                    final box = GetStorage();
                                                    final String? userId = box
                                                        .read('userid');
                                                    String addressText =
                                                        (selectedAddress !=
                                                                null &&
                                                            selectedAddress!['title'] !=
                                                                null &&
                                                            selectedAddress!['detail'] !=
                                                                null)
                                                        ? '${selectedAddress!['title']}, ${selectedAddress!['detail']}'
                                                        : 'No address selected';
                                                    if (userId != null &&
                                                        userId.isNotEmpty) {
                                                      context
                                                          .read<OrderBloc>()
                                                          .add(
                                                            OrderNowSubmitted(
                                                              userId,
                                                              addressText,
                                                            ),
                                                          );
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "User ID not found!",
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppsColors.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            elevation: 2,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.h,
                                            ),
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Opacity(
                                                opacity: isLoading ? 0 : 1,
                                                child: Text(
                                                  (cart1 == null ||
                                                          (cart1.grandTotal ??
                                                                  0) ==
                                                              0)
                                                      ? "Order now"
                                                      : "Order now - ₹${cart1.grandTotal}",
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              if (isLoading)
                                                SizedBox(
                                                  height: 20.h,
                                                  width: 20.h,
                                                  child:
                                                      const CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2,
                                                      ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                  PromoBottomCard(
                                    message:
                                        "Har zaroorat,\nBas kuch minute mein\ndelivered ❤️",
                                  ),
                                
                               SizedBox(height: 20.h),
                                
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
          ),
        );
      },
    );
  }
}

class _CartList extends StatefulWidget {
  final ViewCartEntity cart;
  const _CartList({required this.cart});

  @override
  State<_CartList> createState() => _CartListState();
}

class _CartListState extends State<_CartList> {
  final Map<String, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    for (var item in widget.cart.cartList) {
      _quantities[item.productId] = item.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cart.cartList.isEmpty) {
      return const Center(child: Text('Cart is empty'));
    }

    return Column(
      children: [
        for (var item in widget.cart.cartList) ...[
          _CartItemCard(
            imageUrl: item.productImage,
            name: item.productName,
            subtitle: item.productId, // fallback
            quantity: _quantities[item.productId] ?? item.quantity,
            productsquanity: item.productQuantity,
            price: item.discountPrice,
            originalPrice: item.price,
            prodctid: item.productId,
            onIncrease: () {
              setState(() {
                _quantities[item.productId] =
                    (_quantities[item.productId] ?? item.quantity) + 1;
              });
            },
            onDecrease: () {
              final qty = _quantities[item.productId] ?? item.quantity;
              if (qty > 1) {
                setState(() {
                  _quantities[item.productId] = qty - 1;
                });
              }
            },
          ),
          // Divider after each item
          Divider(color: Colors.grey.shade300, thickness: 0.8),
        ],
      ],
    );
  }
}

class _CartItemCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String subtitle;
  final num quantity;
  final String productsquanity;
  final num price;
  final String prodctid;
  final num originalPrice;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const _CartItemCard({
    required this.imageUrl,
    required this.name,
    required this.subtitle,
    required this.quantity,
    required this.productsquanity,
    required this.price,
    required this.originalPrice,
    required this.onIncrease,
    required this.onDecrease,

    required this.prodctid,
  });

  @override
  State<_CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<_CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: SmartCachedImage(
            imageUrl: widget.imageUrl,
            width: 50.w,
            height: 50.h,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 14.w),
        // Name + Quantity
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
              SizedBox(height: 2.h),
              Text(
                "Net Qty : ${widget.productsquanity}",

                style: TextStyle(
                  color: AppsColors.textclourgray,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        // Stepper
        CartStepper(
          productId: widget.prodctid,
          quantity: widget.quantity.toString(),
        ),
        // Price
        SizedBox(
          width: 35.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.price.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              Text(
                widget.originalPrice.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppsColors.textclourgray,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CartStepper extends StatefulWidget {
  final String productId;
  final String quantity; // String type

  const CartStepper({
    super.key,
    required this.productId,
    required this.quantity,
  });

  @override
  State<CartStepper> createState() => _CartStepperState();
}

class _CartStepperState extends State<CartStepper> {
  bool isAdding = false; // Loader flag
  final userId = GetStorage().read("userid") ?? '';
  void addToCart(String type) {
    setState(() {
      isAdding = true; // Loader start
    });

    context.read<CartBloc>().add(
      AddCartItemEvent(
        CartItemEntity(
          userId: userId,
          productId: widget.productId,
          action: type,
          // quantityChange: delta, // Agar API me required ho
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quantity = int.tryParse(widget.quantity) ?? 0;

    return Container(
      height: 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: AppsColors.primary,
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ---------- MINUS BUTTON ----------
          GestureDetector(
            onTap: (isAdding) ? null : () => addToCart("decrement"),

            child: Container(
              width: 28.w,
              height: 28.h,
              alignment: Alignment.center,
              child: Icon(Icons.remove, size: 16.sp, color: Colors.white),
            ),
          ),

          SizedBox(width: 8.w),

          // ---------- QUANTITY DISPLAY ----------
          Container(
            width: 30.w,
            alignment: Alignment.center,
            child: isAdding
                ? SizedBox(
                    width: 16.sp,
                    height: 16.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    '$quantity',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
          ),

          SizedBox(width: 8.w),

          // ---------- PLUS BUTTON ----------
          GestureDetector(
            onTap: isAdding ? null : () => addToCart("increment"),
            child: Container(
              width: 28.w,
              height: 28.h,
              alignment: Alignment.center,
              child: Icon(Icons.add, size: 16.sp, color: Colors.white),
            ),
          ),

          // ---------- BLOC LISTENER ----------
          BlocListener<CartBloc, CartState>(
            listener: (context, state) async {
              final userId = GetStorage().read("userid") ?? '';
              if (userId.isEmpty) return;

              if (state is CartSuccess) {
                // Update related blocs
                context.read<ViewCartBloc>().add(LoadViewCart(userId: userId));
                context.read<CartCountBloc>().add(LoadCartCount(userId));

                // Stop loader after short delay for smooth UI
                await Future.delayed(Duration(milliseconds: 100));
                setState(() => isAdding = false);
                // ✅ Show success message
              }

              if (state is CartFailure) {
                setState(() => isAdding = false);

                // ❌ Show failure message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const SizedBox.shrink(),
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
