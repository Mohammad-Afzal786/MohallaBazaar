import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';

class MohallaBazaarLogo2 extends StatelessWidget {
  const MohallaBazaarLogo2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Mohalla Bazaar (center aligned)
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 26.sp.clamp(18, 26), // responsive with min–max
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: "Mohalla ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppsColors.white,
                ),
              ),
              TextSpan(
                text: "Bazaar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 6.h), // ✅ responsive gap

        // Slogan (center aligned)
        Text(
          "30 minutes delivery app",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp.clamp(10, 14), // responsive min–max
            fontWeight: FontWeight.bold,
            color: AppsColors.white,
          ),
        ),
      ],
    );
  }
}
