import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/pages/createaccountpage.dart';
import '../../../../core/utils/nav_helper.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final box = GetStorage();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  bool _obscurePassword = true;
  String? fcmtoken;

  @override
  void initState() {
    super.initState();
    final savedRemember = box.read('rememberMe') ?? false;
    fcmtoken = box.read('fcmtoken');
    if (savedRemember) {
      phoneController.text = box.read('phone') ?? '';
      passwordController.text = box.read('password') ?? '';
      rememberMe = true;
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (rememberMe) {
      box.write('phone', phoneController.text.trim());
      box.write('password', passwordController.text.trim());
      box.write('rememberMe', true);
    } else {
      box.remove('email');
      box.remove('password');
      box.write('rememberMe', false);
    }

    final token = fcmtoken ?? box.read('fcmtoken') ?? '';
    context.read<LoginBloc>().add(
      LoginSubmitted(
        phoneController.text.trim(),
        passwordController.text.trim(),
        token,
      ),
    );
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
    // ✅ keyboard close FIRST
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.success) {
                box.write('userid', state.data!.userid);
                box.write('username', state.data!.user.name);
                box.write('userphone', state.data!.user.phone);
                NavHelper.goToDashboard();
              } else if (state.status == LoginStatus.failure) {
                showErrorDialog(
                  context,
                  state.error ?? "Something went wrong!",
                  success: false,
                );
              }
            },
            builder: (context, state) {
              final isLoading = state.status == LoginStatus.loading;
              return Column(
                children: [
                  SizedBox(height: 30.h),
                  Text(
                    "Customer Login",
                    style: TextStyle(
                      color: AppsColors.primary,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Welcome back you’ve\nbeen missed!",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 30.h),
                            _buildTextField(
                              hintText: 'Phone Number',
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              controller: phoneController,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // only numbers
                                LengthLimitingTextInputFormatter(
                                  10,
                                ), // max 10 digits
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
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: isLoading
                                      ? null
                                      : (v) => setState(
                                          () => rememberMe = v ?? false,
                                        ),
                                ),
                                Text(
                                  "Remember Me",
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: () =>
                                      NavHelper.goToForgetPassword(),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets
                                        .zero, // text ke around extra space nahi
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    splashFactory:
                                        NoSplash.splashFactory, // ❌ ripple off
                                    overlayColor: Colors
                                        .transparent, // ❌ gray overlay off
                                  ),
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: AppsColors.primary,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            SizedBox(
                              width: double.infinity,
                              height: 50.h,
                              child: ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () => _onSubmit(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppsColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: isLoading
                                    ? SizedBox(
                                        width: 22.w,
                                        height: 22.w,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "Sign In",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: 18.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  child: Text(
                                    "Don't have an account? ",
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
                                onPressed: NavHelper.goToCreateAccount,
                                child: Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: AppsColors.primary,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
