import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_event.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_state.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/pages/createaccountpage.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  /// 👉 Action when Continue button is pressed
  void _onContinue() {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      showErrorDialog(
        context,
        "  Please enter your Phone Number",
        success: false,
      );
    } else {
      /// Bloc को event भेज रहे हैं
      context.read<ForgotPassBloc>().add(ForgotPassSubmitted(email));
    }
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
    // Close keyboard first
    FocusManager.instance.primaryFocus?.unfocus();

    // Small delay to settle IME
    await Future.delayed(const Duration(milliseconds: 150));

    // ✅ Check if any dialog is open
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // This will close dialog if open
      return false; // handled pop
    }

    // Else, go back to login screen
    NavHelper.backToLogin();
    return false; // handled pop
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppsColors.white,
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
              onPressed: () async {
                // 🔹 await so that navigation works properly
                await _onWillPop();
              },
            ),
          ),
          title: Image.asset(
            "assets/images/logo.png",
            height: 70.h,
            fit: BoxFit.contain,
          ),
        ),

        body: BlocListener<ForgotPassBloc, ForgotPassState>(
          listener: (context, state) {
            if (state.status == ForgotPassStatus.success) {
              final userId =
                  state.data?.data.userId ?? ""; // 👈 API से आया userId
              NavHelper.goTochangepass(userId);
            } else if (state.status == ForgotPassStatus.failure) {
              showErrorDialog(
                context,
                state.error ?? "Something went wrong!",
                success: false,
              );
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Logo
                  SizedBox(height: 16.h),

                  /// Title & Subtitle
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Get help logging into your account.",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  ),
                  SizedBox(height: 24.h),
                  _buildTextField(
                    hintText: 'Phone Number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    controller: emailController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // only numbers
                      LengthLimitingTextInputFormatter(10), // max 10 digits
                    ],
                  ),

                  SizedBox(height: 32.h),

                  /// Continue Button
                  BlocBuilder<ForgotPassBloc, ForgotPassState>(
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
                          onPressed: state.status == ForgotPassStatus.loading
                              ? null
                              : _onContinue,
                          child: state.status == ForgotPassStatus.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Continue',
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
        ),
      ),
    );
  }
}
