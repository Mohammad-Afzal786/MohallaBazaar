import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({super.key});

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  @override
  void initState() {
    super.initState();
    //  final box = GetStorage();
    //   final userid = box.read("userid");

    //   // 🔄 Refresh the cart and count
    //    context.read<ViewCartBloc>().add(LoadViewCart(userId: userid));
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) NavHelper.backToordersuccessfully();
      },

      child: Scaffold(
        backgroundColor: AppsColors.primary,

        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: AppsColors.primary,
            ),
            SizedBox(height: 20.h),

            // ✅ Back Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () =>
                      NavHelper.backToordersuccessfully(), // Back to previous page
                  child: SizedBox(
                    width: 35.w,
                    height: 35.w,

                    child: Icon(
                      CupertinoIcons.back,
                      color: AppsColors.white,
                      size: 22.sp,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // ✅ Circular top image
            Container(
              width: 200.w,
              height: 200.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(4),
              child: ClipOval(
                child: SmartCachedImage(
                  imageUrl:
                      "https://img.freepik.com/premium-vector/online-delivery-phone-concept-fast-respond-delivery-package-shipping-mobile_420121-241.jpg",
                  fit: BoxFit.cover,
                  width: 200.w,
                  height: 200.w,
                ),
              ),
            ),
            SizedBox(height: 30.h),

            // ✅ Awesome Badge
            Container(
              width: 120.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Awesome",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppsColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),

            // ✅ Success Texts
            Text(
              "Congratulations.",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "Your order is accepted!",
              style: TextStyle(fontSize: 22.sp, color: Colors.white),
            ),

            // ✅ Bottom Card with Buttons (no scroll)
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 32.h,
                    horizontal: 18.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 6, color: Colors.black12),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.w),
                        child: Text(
                          "Have patience you can collect your order in 30 min later",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppsColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            
                            NavHelper.goToOrdertrack();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppsColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Text(
                            "Track Your Order",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.w),
                        child: Text(
                          "More Hungry, Let's do again",
                          style: TextStyle(
                            fontSize: 14.sp,

                            color: AppsColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
