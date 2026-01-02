import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MohallaBazaarLogo extends StatelessWidget {
  const MohallaBazaarLogo({super.key});

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
              fontSize: 30.sp.clamp(18, 26), // responsive with min–max
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: "Mohalla ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff108ac4),
                ),
              ),
              TextSpan(
                text: "Bazaar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xfffc6c01),
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
            color: Color(0xfffc6c01),
          ),
        ),
      ],
    );
  }
}
