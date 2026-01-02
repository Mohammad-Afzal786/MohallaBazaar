import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/constants/app_lotte_files.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntropageData> pages = [
    IntropageData(
      imagePath: AppLotteFiles.onboarding1,
      title: 'Browse all the category',
      subtitle: 'सभी प्रोडक्ट्स और कैटेगरी एक ही जगह आसानी से ब्राउज़ करें।',
      buttonText: 'Next',
    ),
    IntropageData(
      imagePath: AppLotteFiles.onboarding2,
      title: 'Delivery in 30 Min',
      subtitle: 'आपके ऑर्डर अब आपके दरवाज़े तक सिर्फ 30 मिनट में पहुँचेंगे।',
      buttonText: 'Next',
    ),
    IntropageData(
      imagePath: AppLotteFiles.onboarding3,
      title: 'Discounts & Offers',
      subtitle: 'हर ऑर्डर पर पाएं बेहतरीन डिस्काउंट और शानदार ऑफ़र।',
      buttonText: 'Get Started',
    ),
  ];

  void _onPageChanged(int index) => setState(() => _currentPage = index);

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _goToPage(_currentPage + 1);
    } else {
      GetStorage().write('seenIntro', true);
      Get.offAllNamed('/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 804), // iPhone 13 base
      builder: (context, child) {
        return Scaffold(
  body: SafeArea(
    child: Column(
      children: [
        /// 🔹 PageView (content)
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              final page = pages[index];
              return Column(
                children: [
                  /// Animation
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: Lottie.asset(
                        page.imagePath,
                        width: 0.9.sw,
                        height: 0.45.sh,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  /// Title + Subtitle
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            page.title,
                            
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp.clamp(18, 32),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15.sp.clamp(12, 18),
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        /// 🔹 Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pages.length,
            (index) => GestureDetector(
              onTap: () => _goToPage(index),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: _currentPage == index ? 16.w : 10.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppsColors.primary
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 20.h),

        /// 🔹 Next / Get Started Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SizedBox(
            width: double.infinity,
            height: 60.h,
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppsColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                pages[_currentPage].buttonText,
                style: TextStyle(
                  fontSize: 16.sp.clamp(14, 20),
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 30.h),
      ],
    ),
  ),
);

      
      },
    );
  }
}

class IntropageData {
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;

  IntropageData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });
}
