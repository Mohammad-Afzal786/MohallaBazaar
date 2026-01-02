import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';

class PromoBottomCard extends StatelessWidget {
  final String message;
  const PromoBottomCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white, // 👈 simple light background
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Heading text
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                height: 1.3,
              ),
              children: [
                const TextSpan(text: "Har zaroorat,\n"),
                const TextSpan(text: "Bas kuch minute mein\n"),
                TextSpan(
                  text: "delivered ",
                  style: TextStyle(
                    color: AppsColors.primary, // 👈 green highlight
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          /// Footer line
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 10.sp, color: Colors.black87),
                    children: [
                      const TextSpan(
                        text: "Thank you for your trust — with love, ",
                      ),
                      TextSpan(
                        text: "Mohalla Bazaar Team",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppsColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
