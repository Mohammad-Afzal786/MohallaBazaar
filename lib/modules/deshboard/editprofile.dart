import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart'; // 👈 जरूर import करें


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: "Dor Alex");
  final _emailController = TextEditingController(text: "alexd@gmail.com");
  final _passwordController = TextEditingController(text: "");
  final _locationController = TextEditingController(text: "TLV, Israel");

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(fontSize: 18.sp), // responsive text
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () => NavHelper.backToProfileFromEdit(),
        ),
       
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // 👈 responsive padding
        child: Column(
          children: [
            // Profile image with edit icon
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50.r, // responsive radius
                  backgroundImage: AssetImage('assets/images/img.png'),
                  backgroundColor: Colors.grey[300],
                ),
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppsColors.primary,
                  child: Icon(Icons.edit, color: Colors.white, size: 16.sp),
                )
              ],
            ),
            SizedBox(height: 24.h),

            // Full Name
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Full Name",
                labelStyle: TextStyle(color: AppsColors.textDark, fontSize: 14.sp),
                 enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppsColors.textDark, width: 1),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppsColors.primary, width: 2),
    ),
              ),
            ),
            SizedBox(height: 12.h),

            // E-mail
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(color: AppsColors.textDark,fontSize: 14.sp),
               
                 enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppsColors.textDark, width: 1),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppsColors.primary, width: 2),
    ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 12.h),

            // Password
            TextField(
              controller: _passwordController,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: AppsColors.textDark, fontSize: 14.sp),
                enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppsColors.textDark, width: 1),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppsColors.primary, width: 2),
    ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    size: 18.sp,
                  ),
                  onPressed: () {
                    setState(() => _showPassword = !_showPassword);
                  },
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Location
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: "Location",
                labelStyle: TextStyle(color: AppsColors.textDark,fontSize: 14.sp),
               
                 enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppsColors.textDark, width: 1),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppsColors.primary, width: 2),
    ),
              ),
            ),
            Spacer(),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => NavHelper.backToProfileFromEdit(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      textStyle: TextStyle(fontSize: 14.sp),
                      foregroundColor: AppsColors.primary,

                    ),
                    child: Text("CANCEL"),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Save profile logic here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      backgroundColor: AppsColors.primary,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 14.sp),
                    ),
                    child: Text("SAVE"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
