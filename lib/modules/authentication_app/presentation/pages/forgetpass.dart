import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
import 'package:mohalla_bazaar/core/widget/mohallabazaarlogo.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_event.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_state.dart';

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
      Get.snackbar("Error", "Please enter your email");
    } else {
      /// Bloc को event भेज रहे हैं
      context.read<ForgotPassBloc>().add(ForgotPassSubmitted(email));
    }
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
      body: BlocListener<ForgotPassBloc, ForgotPassState>(
        listener: (context, state) {
          if (state.status == ForgotPassStatus.success) {
             final userId = state.data?.data.userId ?? ""; // 👈 API से आया userId
            NavHelper.goTochangepass(userId);
          } else if (state.status == ForgotPassStatus.failure) {
            Get.snackbar("Error", state.error ?? "Something went wrong");
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Logo
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Center(child: MohallaBazaarLogo()),
                ),
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

                /// Email TextField
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 16.sp),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        color: AppsColors.primary,
                        width: 2,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 20.sp,
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 12.w,
                    ),
                  ),
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
    );
  }
}
