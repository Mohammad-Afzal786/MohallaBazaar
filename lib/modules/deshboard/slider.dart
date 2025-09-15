import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/constants/app_images.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';

class CustomSliderPageView extends StatefulWidget {
  const CustomSliderPageView({super.key});

  @override
  _CustomSliderPageViewState createState() => _CustomSliderPageViewState();
}

class _CustomSliderPageViewState extends State<CustomSliderPageView> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  bool _isForward = true; // 👈 Direction flag
  Timer? _timer;

  final List<String> pages = [
    AppImages.b1,
    AppImages.b2,
    AppImages.b3,
  ];

  @override
  void initState() {
    super.initState();

    /// Auto play timer
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_isForward) {
        if (_currentPage < pages.length - 1) {
          _currentPage++;
        } else {
          _isForward = false; // 👈 reverse chalu karo
          _currentPage--;
        }
      } else {
        if (_currentPage > 0) {
          _currentPage--;
        } else {
          _isForward = true; // 👈 forward chalu karo
          _currentPage++;
        }
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      setState(() {}); // indicator update
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentPage = index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// PageView
        SizedBox(
          height: 160.h,
          child: PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  pages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),

        /// Indicator Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pages.length,
            (index) => GestureDetector(
              onTap: () => _goToPage(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: _currentPage == index ? 18.w : 12.w,
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
      ],
    );
  }
}
