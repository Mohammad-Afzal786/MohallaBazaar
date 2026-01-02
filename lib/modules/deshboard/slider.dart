import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mohalla_bazaar/core/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohalla_bazaar/core/utils/smartcachedImag.dart';
import 'package:mohalla_bazaar/modules/banner/presentation/bloc/banner_bloc.dart';
import 'package:mohalla_bazaar/modules/banner/presentation/bloc/banner_state.dart';

class CustomSliderPageView extends StatefulWidget {
  const CustomSliderPageView({super.key});

  @override
  CustomSliderPageViewState createState() => CustomSliderPageViewState();
}

class CustomSliderPageViewState extends State<CustomSliderPageView> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  bool _isForward = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final bannerState = context.read<BannerBloc>().state;
      final banners = bannerState.banners;

      if (banners.isEmpty) return;

      if (_isForward) {
        if (_currentPage < banners.length - 1) {
          _currentPage++;
        } else {
          _isForward = false;
          _currentPage--;
        }
      } else {
        if (_currentPage > 0) {
          _currentPage--;
        } else {
          _isForward = true;
          _currentPage++;
        }
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      setState(() {});
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
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        final banners = state.banners;

        if (banners.isEmpty) {
          return SizedBox(
            height: 100.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return Column(
          children: [
            // PageView
            SizedBox(
              height: 100.h,
              child: PageView.builder(
                controller: _controller,
                itemCount: banners.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: SmartCachedImage(imageUrl: 
                    banners[index].imageUrl,        
                    )
                    
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            // Indicator Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
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
      },
    );
  }
}
