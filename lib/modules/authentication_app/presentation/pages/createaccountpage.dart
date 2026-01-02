import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/ragistar_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/ragistar_event.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/ragister_state.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool agreeTerms = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final box = GetStorage();
  final TapGestureRecognizer _privacyRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _termsRecognizer = TapGestureRecognizer();
  bool _obscurePassword = true;
  String fcmtoken = '';

  @override
  void initState() {
    super.initState();
    
    fcmtoken = box.read('fcmtoken') ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    _privacyRecognizer.dispose();
    _termsRecognizer.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    TextEditingController? controller,
    Widget? suffix,
    List<TextInputFormatter>? inputFormatters, // ✅ add
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      inputFormatters: inputFormatters, // ✅ add
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54, size: 22.sp),
        prefixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        counterText: "", // ✅ hide 0/10
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppsColors.primary, width: 1),
        ),
        suffixIcon: suffix,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // ✅ small delay so IME settles
    await Future.delayed(const Duration(milliseconds: 150));

    if (!mounted) return false; // 🛡 safety
    final shouldExit = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Are you sure want to Exit?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              Text(
                "It seems like you're asking about Exit.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.sp, color: Colors.black54),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.fromHeight(40.h),
                        side: BorderSide(color: AppsColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppsColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => SystemNavigator.pop(),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40.h),
                        backgroundColor: AppsColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
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
    );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 64.h,
          centerTitle: true,
          leadingWidth: 56.w,
          leading: Padding(
            padding: EdgeInsets.only(top: 18.h),
            child: IconButton(
              icon: Icon(
                CupertinoIcons.chevron_back,
                size: 30.sp,
                color: Colors.black,
              ),
              style: IconButton.styleFrom(
                splashFactory: NoSplash.splashFactory, // ❌ ripple off
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              onPressed: _onWillPop,
            ),
          ),
          title: Image.asset(
            "assets/images/logo.png",
            height: 70.h,
            fit: BoxFit.contain,
          ),
        ),
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.success) {
              box.write('userid', state.data!.userId);
              box.write('username', state.data!.name);
              box.write('userphone', state.data!.phone);

              NavHelper.goToDashboard();
            } else if (state.status == RegisterStatus.failure) {
              showErrorDialog(
                context,
                state.error ?? "Something went wrong!",
                success: false,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "Create Account",
                    style: TextStyle(
                      color: AppsColors.primary,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Create an account so you can explore all the available products",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15.sp),
                  ),
                  SizedBox(height: 24.h),
                  _buildTextField(
                    hintText: 'Name',
                    icon: Icons.person_2_outlined,
                    keyboardType: TextInputType.name,
                    controller: nameController,
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    hintText: 'Phone Number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // only numbers
                      LengthLimitingTextInputFormatter(10), // max 10 digits
                    ],
                  ),
                  SizedBox(height: 16.h),
                  _buildTextField(
                    hintText: 'Password',
                    icon: Icons.lock_outline,
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: agreeTerms,
                        onChanged: (val) =>
                            setState(() => agreeTerms = val ?? false),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        activeColor: AppsColors.primary,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.sp,
                            ),
                            children: [
                              const TextSpan(text: 'I agree to '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: AppsColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: _privacyRecognizer,
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Terms of Use',
                                style: TextStyle(
                                  color: AppsColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: _termsRecognizer,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: agreeTerms
                          ? () {
                              context.read<RegisterBloc>().add(
                                RegisterSubmitted(
                                  name: nameController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  fcmtoken: fcmtoken,
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppsColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 2,
                      ),
                      child: state.status == RegisterStatus.loading
                          ? SizedBox(
                              width: 22.w,
                              height: 22.w,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: Colors.transparent,
                      ),
                      onPressed: () => NavHelper.goToLogin(),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: AppsColors.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void showErrorDialog(
  BuildContext context,
  String message, {
  bool success = true,
}) {
  showDialog(
    context: context,
    barrierDismissible: true, // user can tap outside to dismiss
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error,
                size: 48,
                color: success ? AppsColors.primary : Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: success ? AppsColors.primary : Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 16, color: Colors.white),
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
