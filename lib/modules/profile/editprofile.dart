import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/modules/profile/updateprofile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  final bool _showPassword = false;
  final box = GetStorage();
  late AnimationController _anim;
  late Animation<double> _slide;

  late final _nameController = TextEditingController(
    text: box.read("username") ?? '',
  );

  late final _locationController = TextEditingController(
    text: box.read("userphone") ?? '',
  );

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slide = CurvedAnimation(parent: _anim, curve: Curves.easeOutExpo);
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     
    final color = AppsColors.primary;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppsColors.primary,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Container(
                    color: AppsColors.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
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

                  Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                      children: [
                        // Glass Card for fields
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 22.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(22.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _field(
                                "Full Name",
                                Icons.person_outline_rounded,
                                _nameController,
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Save Button
                        SizedBox(
                          height: 45.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color,
                              foregroundColor: Colors.white,
                              
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              elevation: 8,
                            ),
                            onPressed: () async {
                              final box = GetStorage();
                              final userId = box.read("userid") ?? '';
                          
                              final success = await UserApi().updateUserProfile(
                                userId: userId,
                                name: _nameController.text.trim(),
                              );
                          
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      "✅ Profile Updated Successfully!",
                                    ),
                                    backgroundColor: color,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                );
                          
                                box.write(
                                  "username",
                                  _nameController.text.trim(),
                                );
                                box.write(
                                  "userphone",
                                  _locationController.text.trim(),
                                );
                                Navigator.pop(context, true);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      "❌ Failed to update profile!",
                                    ),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "SAVE CHANGES",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
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

  Widget _field(
    String label,
    IconData icon,
    TextEditingController ctrl, {
    bool obscure = false,
    TextInputType type = TextInputType.text,
    Widget? suffix,
  }) {
    final color = AppsColors.primary;
    return TextField(
      controller: ctrl,
      obscureText: obscure,
      keyboardType: type,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: color, size: 22.sp),
        suffixIcon: suffix,
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: color, width: 1.5.w),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      ),
    );
  }
}

// Optional: curved header clipper
class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80.h);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 80.h,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
