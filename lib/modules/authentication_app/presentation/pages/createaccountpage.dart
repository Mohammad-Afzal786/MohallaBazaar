import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final _firstNameController = TextEditingController();
  final _lastNameController  = TextEditingController();
  final _emailController     = TextEditingController();
  final _phoneController     = TextEditingController();
  final _passwordController  = TextEditingController();

  final TapGestureRecognizer _privacyRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer _termsRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    _privacyRecognizer.onTap = () => Get.toNamed('/privacy');
    _termsRecognizer.onTap = () => Get.toNamed('/terms');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _privacyRecognizer.dispose();
    _termsRecognizer.dispose();
    super.dispose();
  }

  /// ✅ Custom TextField Widget
  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54, size: 20.sp),
        prefixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 30.h),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: IconButton(
            icon: Icon(CupertinoIcons.back, color: Colors.black, size: 24.sp),
            onPressed: () => NavHelper.backToLogin(),
          ),
        ),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.success) {
            Get.snackbar("Success", "Account created successfully!");
            NavHelper.goToLogin();
          } else if (state.status == RegisterStatus.failure) {
            Get.snackbar("Error", state.error ?? "Something went wrong");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            child: Column(
              children: [
                SizedBox(height: 10.h),

                /// ✅ Responsive Heading
                AutoSizeText(
                  'Let’s create your account',
                  maxLines: 2,
                  minFontSize: 16,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 24.h),

                /// First + Last Name
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        hintText: 'First Name',
                        icon: Icons.person_outline,
                        controller: _firstNameController,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildTextField(
                        hintText: 'Last Name',
                        icon: Icons.person_outline,
                        controller: _lastNameController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                _buildTextField(
                  hintText: 'E-Mail',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                SizedBox(height: 16.h),

                _buildTextField(
                  hintText: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                ),
                SizedBox(height: 16.h),

                _buildTextField(
                  hintText: 'Password',
                  icon: Icons.lock_outline,
                  obscureText: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 16.h),

                /// Terms Checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: agreeTerms,
                      onChanged: (val) {
                        setState(() {
                          agreeTerms = val ?? false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      activeColor: AppsColors.primary,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black54, fontSize: 13.sp),
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

                /// Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: agreeTerms
                        ? () {
                            context.read<RegisterBloc>().add(
                                  RegisterSubmitted(
                                   
                                     firstName:  _firstNameController.text, 
                                     lastName:  _lastNameController.text,
                                      email: _emailController.text,
                                       password: _passwordController.text,
                                        phone:  _phoneController.text,
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
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Create Account',
                            style: TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                  ),
                ),
                SizedBox(height: 24.h),

                /// Divider
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1, color: Colors.grey.shade300)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        "or",
                        style: TextStyle(color: Colors.black54, fontSize: 13.sp),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Colors.grey.shade300)),
                  ],
                ),
                SizedBox(height: 20.h),

                /// Already have account
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                      children: [
                        const TextSpan(text: "Already have an account? "),
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                            color: AppsColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              NavHelper.goToLogin();
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
