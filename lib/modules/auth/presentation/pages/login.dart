import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/widget/mohallabazaarlogo.dart';
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    final savedRemember = box.read('rememberMe') ?? false;
    if (savedRemember) {
      emailController.text = box.read('email') ?? '';
      passwordController.text = box.read('password') ?? '';
      rememberMe = true;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (rememberMe) {
      box.write('email', emailController.text.trim());
      box.write('password', passwordController.text.trim());
      box.write('rememberMe', true);
    } else {
      box.remove('email');
      box.remove('password');
      box.write('rememberMe', false);
    }

    context.read<LoginBloc>().add(
      LoginSubmitted(
        emailController.text.trim(),
        passwordController.text.trim(),
      ),
    );
  }

  /// ✅ Reusable TextField
  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54, size: 20),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.black54),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              box.write('accessToken', state.data!.accessToken);
              box.write('refreshToken', state.data!.refreshToken);
              NavHelper.goToDashboard();
            } else if (state.status == LoginStatus.failure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error ?? 'Error')));
            }
          },
          builder: (context, state) {
            final isLoading = state.status == LoginStatus.loading;

            return Column(
              children: [
                /// 🔹 Top Logo Section
                Padding(
                  padding: EdgeInsets.only(top: 40.h, bottom: 20.h),
                  child: Center(
                    child: SizedBox(height: 90.h, child: MohallaBazaarLogo()),
                  ),
                ),

                /// 🔹 Expanded Form Section
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 5.h,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Welcome text
                          AutoSizeText(
                            "Welcome",
                            maxLines: 1,
                            minFontSize: 18,
                            style: TextStyle(
                              color: AppsColors.primary,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30.h),

                          /// Email
                          _buildTextField(
                            controller: emailController,
                            hintText: 'E-Mail',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Email required';
                              }
                              if (!RegExp(
                                r'^[^@]+@[^@]+\.[^@]+',
                              ).hasMatch(v.trim())) {
                                return 'Enter valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),

                          /// Password
                          _buildTextField(
                            controller: passwordController,
                            hintText: 'Password',
                            icon: Icons.lock_outline,
                            obscureText: _obscurePassword,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Password required';
                              }
                              if (v.length < 6) return 'Min 6 characters';
                              return null;
                            },
                            suffix: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 12.h),

                          /// Remember Me + Forgot Password
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: isLoading
                                    ? null
                                    : (value) {
                                        setState(
                                          () => rememberMe = value ?? false,
                                        );
                                      },
                              ),
                              const Text(
                                "Remember Me",
                                style: TextStyle(fontSize: 13),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => NavHelper.goToForgetPassword(),
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: AppsColors.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),

                          /// Sign In Button
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
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Sign In",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                         
                          SizedBox(height: 18.h),

                          /// Divider with OR
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: const Text(
                                  "or",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
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

                          /// Create Account
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                              children: [
                                const TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  text: "Create Account",
                                  style: TextStyle(
                                    color: AppsColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        NavHelper.goToCreateAccount(),
                                ),
                              ],
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
    );
  }
}
