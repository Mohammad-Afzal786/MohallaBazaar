import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          NavHelper.backToProfile(); // ✅ Home tab पर switch
        }
      },

      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 243, 243),
        body: Column(
          children: [
            /// 🔹 Status bar padding
            Container(
              height: MediaQuery.of(context).padding.top,
              color: AppsColors.primary,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: AppsColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
                          /// Back Button
                          GestureDetector(
                            onTap: () => NavHelper.backToProfile(),
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
                                        const TextSpan(text: "mohalla ",style: TextStyle(
   fontFamily: 'Geometry',
                                             
                                        )),
                                        TextSpan(
                                          text: "bazaar",
                                          
                                          style: TextStyle(
                                             fontFamily: 'Geometry',
                                             
                                            color: Color(0xffffffff)),
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

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 22,
                      ),
                      child: Row(
                        children: [
                          // Purple CircleAvatar
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppsColors.primary,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Afzal",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),

                              Text(
                                "8171189604",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Tile Buttons Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ProfileTile(
                            icon: Icons.shopping_bag_outlined,
                            label: 'Your \nOrders',
                            onTap: () {},
                          ),
                          SizedBox(width: 12),
                          _ProfileTile(
                            icon: Icons.support_agent,
                            label: 'Help \n& Support',
                            onTap: () {},
                          ),
                          SizedBox(width: 12),
                          _ProfileTile(
                            icon: Icons.favorite_border,
                            label: 'Your \nWishlist',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                            child: Text(
                              "Your Information",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          // Menu rows - har row manually banayi gayi hai (List nahi)
                          _menuRow(Icons.shopping_bag_outlined, "Your Orders"),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: DashedDivider(
                              color: Colors.black.withValues(
                                alpha: 0.12,
                              ), // 22% opacity
                              height: 1,
                            ),
                          ),
                          _menuRow(Icons.favorite_border, "Your Wishlist"),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: DashedDivider(
                              color: Colors.black.withValues(
                                alpha: 0.12,
                              ), // 22% opacity
                              height: 1,
                            ),
                          ),

                          _menuRow(Icons.help_outline, "Help & Support"),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: DashedDivider(
                              color: Colors.black.withValues(
                                alpha: 0.12,
                              ), // 22% opacity
                              height: 1,
                            ),
                          ),

                          _menuRow(
                            Icons.location_on_outlined,
                            "Saved Addresses",
                            subtitle: "0 Addresses",
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: DashedDivider(
                              color: Colors.black.withValues(
                                alpha: 0.12,
                              ), // 22% opacity
                              height: 1,
                            ),
                          ),
                          _menuRow(Icons.person_outline, "Profile"),
                        ],

                        // Profile Info Section
                      ),
                    ),
                  
                   Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                            child: Text(
                                    "Other Information",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                         
                          // Menu rows - har row manually banayi gayi hai (List nahi)
                          _menuRow(Icons.shopping_bag_outlined,  "Suggest Products"),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: DashedDivider(
                              color: Colors.black.withValues(
                                alpha: 0.12,
                              ), // 22% opacity
                              height: 1,
                            ),
                          ),
                          _menuRow(Icons.favorite_border, "Notifications"),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: DashedDivider(
                              color: Colors.black.withValues(
                                alpha: 0.12,
                              ), // 22% opacity
                              height: 1,
                            ),
                          ),

                          _menuRow(Icons.help_outline, "General Info"),

                          
                         
                         
                        ],

                        // Profile Info Section
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                                       height: 50, // 🔹 Fixed height
                                width: double.infinity, // 🔹 Fixed width
                                    
                                       decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300, width: 1),
                                ),
                                      
                                      child: Center(
                                        child: Text(
                      "Log Out", style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                      ),
                                    ),
                    ),
            
            SizedBox(height: 20),
            // Footer for version info
            Text(
              "App version 25.8.4\nv82-10",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey, fontSize: 14, height: 1.2),
            ),
            SizedBox(height: 12),
                  
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

Widget _menuRow(IconData icon, String title, {String? subtitle}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      children: [
        Icon(icon, size: 20),
        SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 12)),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
            ],
          ),
        ),
        Icon(Icons.chevron_right, color: Colors.black),
      ],
    ),
  );
}

class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;

  const DashedDivider({
    super.key,
    this.height = 0.1,
    this.color = Colors.black,
  });

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

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100, // 🔹 Fixed height
          width: 100, // 🔹 Fixed width
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 🔹 Center align
            children: [
              Icon(icon, size: 20, color: Colors.black87),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
