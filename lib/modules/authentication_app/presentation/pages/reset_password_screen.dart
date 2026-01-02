import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/widget/mohallabazaarlogo.dart';
import '../bloc/resetpassword_bloc.dart';
import '../bloc/resetpassword_event.dart';
import '../bloc/resetpassword_state.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String userId;
  const ResetPasswordScreen({super.key, required this.userId});

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  void dispose() {
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  void _onChangePassword() {
    String newPass = newPassController.text.trim();
    String confirmPass = confirmPassController.text.trim();

    if (newPass.isEmpty || confirmPass.isEmpty) {
      Get.snackbar(
        "Error", // Title
        "Please fill all fields"
      );
      
      return;
    } else if (newPass != confirmPass) {
      Get.snackbar(
        "Error", // Title
        "Passwords do not match"
      );
      
      return;
    }

    // ✅ Dispatch BLoC event
    context.read<ResetPasswordBloc>().add(
      ResetPasswordSubmitted(
        userId: widget.userId,
        newPassword: newPass,
        confirmPassword: confirmPass,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppsColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.black, size: 22.sp),
          onPressed: () => NavHelper.backToLogin(),
        ),
        backgroundColor: AppsColors.white,
        elevation: 0,
      ),
      body: BlocListener<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state.status == ResetPasswordStatus.success) {
           Get.snackbar(
        "Success", // Title
        state.message ?? "Password reset successful", // API se ya fallback
       
      );
            // Navigate back to login or other page
            NavHelper.goToLogin();
          } else if (state.status == ResetPasswordStatus.failure) {
            Get.snackbar(
        "Error", // Title
        state.message ?? "Something went wrong", // API error message ya fallback
        
      );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(child: MohallaBazaarLogo()),
              ),
              SizedBox(height: 16.h),
              Text(
                "Change Password",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Enter your new password below.",
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),
              SizedBox(height: 24.h),
              TextField(
                controller: newPassController,
                obscureText: true,
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(
                  labelText: "New Password",
                  labelStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: AppsColors.primary, width: 2),
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: 20.sp,
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 12.w,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: confirmPassController,
                obscureText: true,
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: AppsColors.primary, width: 2),
                  ),
                  prefixIcon: Icon(Icons.lock, size: 20.sp, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 12.w,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 48.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppsColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      onPressed: state.status == ResetPasswordStatus.loading
                          ? null
                          : _onChangePassword,
                      child: state.status == ResetPasswordStatus.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Change Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
