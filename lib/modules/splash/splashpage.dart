import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohalla_bazaar/core/constants/app_images.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
 final userId = box.read('userid');

  // ✅ If user is already logged in, go straight to dashboard
  if (userId != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavHelper.goToDashboard();
    });
    return; // stop further navigation
  }

  // ✅ Otherwise, wait 4 seconds and check intro status
  Future.delayed(const Duration(seconds: 4), () {
    bool seenIntro = box.read('seenIntro') ?? false;
    if (seenIntro) {
      NavHelper.goToCreateAccount();
    } else {
      NavHelper.goToonbording();
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppsColors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// 🔹 Top → Image full width, auto height (NO CROP)
            Image.asset(
              AppImages.splash,
              width: double.infinity,
             
              fit: BoxFit.fitWidth, // ✅ हमेशा full width, no crop
            ),

            /// 🔹 Bottom Half → Logo (center)
            Expanded(
              child: Center(
                child: Image.asset(
          "assets/images/logo.png",
          width: 200, // optional: size adjust karne ke liye
          height: 200,
        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
