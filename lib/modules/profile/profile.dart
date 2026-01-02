import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/config/routes.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/modules/Address_list/address_list.dart';
import 'package:mohalla_bazaar/modules/helpcenter/helpcenter.dart';
import 'package:mohalla_bazaar/modules/profile/editprofile.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final box = GetStorage();
  late String username;
  late String userphone;
  String version = 'Loading...';

  @override
  void initState() {
    super.initState();
    loadProfile();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
    PackageInfo.fromPlatform().then((info) {
      setState(() {
        version = 'App version ${info.version}\nBuild ${info.buildNumber}';
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadProfile();
  }

  void loadProfile() {
    setState(() {
      username = box.read('username') ?? '';
      userphone = box.read('userphone') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) NavHelper.backToProfile();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 243, 243),
        body: Column(
          children: [
            /// Status bar padding
            Container(
              height: MediaQuery.of(context).padding.top,
              color: AppsColors.primary,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Header
                    Container(
                      color: AppsColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
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

                    /// User info
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 22.h,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.w,
                            backgroundColor: AppsColors.primary,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: 30.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                userphone,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// Tile buttons
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ProfileTile(
                            icon: Icons.shopping_bag_outlined,
                            label: 'Your \nOrders',
                            onTap: NavHelper.goToorderhistoryforprofile,
                          ),
                          SizedBox(width: 12.w),
                          _ProfileTile(
                            icon: Icons.support_agent,
                            label: 'Help \n& Support',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const HelpCenterPage()),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          _ProfileTile(
                            icon: Icons.notifications,
                            label: 'Your \nnotification',
                            onTap: NavHelper.goTonotificatin,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Information sections
                    _infoSection("Your Information", [
                      _menuRow(Icons.shopping_bag_outlined, "Your Orders",
                          onTap: NavHelper.goToorderhistoryforprofile),
                      _menuRow(Icons.help_outline, "Help & Support", onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HelpCenterPage()),
                        );
                      }),
                      _menuRow(Icons.location_on_outlined, "Saved Addresses",
                          onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AddressListPage()),
                        );
                      }),
                      _menuRow(Icons.person_outline, "Profile", onTap: () async {
                        final bool? updated = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EditProfilePage()),
                        );
                        if (updated == true) loadProfile();
                      }),
                    ]),

                    _infoSection("Other Information", [
                      _menuRow(Icons.favorite_border, "Notifications",
                          onTap: NavHelper.goTonotificatin),
                    ]),

                    /// Log out
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: GestureDetector(
                        onTap: () async {
                          final box = GetStorage();
                          final fcmToken = box.read('fcmtoken');
                          final phone = box.read('phone');
                          final password = box.read('password');
                          final rememberMe = box.read('rememberMe');

                          await box.erase();

                          if (fcmToken != null) await box.write('fcmtoken', fcmToken);
                          if (rememberMe == true) {
                            await box.write('phone', phone);
                            await box.write('password', password);
                            await box.write('rememberMe', true);
                          }

                          Get.offAllNamed(AppRoutes.login);
                        },
                        child: Container(
                          height: 50.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.w,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Version info
                    Text(
                      version,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp, height: 1.2),
                    ),
                    SizedBox(height: 12.h),
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

// Responsive info section
Widget _infoSection(String title, List<Widget> children) {
  return Container(
    margin: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: Colors.grey.shade300, width: 1.w),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
        ...children
            .expand((e) => [
                  e,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: DashedDivider(
                        color: Colors.black.withOpacity(0.12), height: 1.h),
                  )
                ])
            .toList()
          ..removeLast(),
      ],
    ),
  );
}

// Menu row
Widget _menuRow(IconData icon, String title, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Icon(icon, size: 20.sp),
          SizedBox(width: 18.w),
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 12.sp)),
          ),
          Icon(Icons.chevron_right, color: Colors.black),
        ],
      ),
    ),
  );
}

// Dashed divider
class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;
  const DashedDivider({super.key, this.height = 0.1, this.color = Colors.black});
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
    final paint = Paint()..color = color..strokeWidth = height;
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

// Profile tile
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ProfileTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300, width: 1.w),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20.sp, color: Colors.black87),
              SizedBox(height: 10.h),
              Text(
                label,
                style: TextStyle(
                    fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
