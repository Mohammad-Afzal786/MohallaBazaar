import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mohalla_bazaar/core/constants/app_lotte_files.dart';

class SearchBarWidget extends StatefulWidget {
  final List<String>? hints;
  final String? lottieFile;
  final Widget Function()? searchPageBuilder;

  const SearchBarWidget({
    super.key,
    this.hints,
    this.lottieFile,
    this.searchPageBuilder,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final List<String> _hints;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _hints =
        widget.hints ??
        ['Search "chips"', 'Search "milk"', 'Search "bread"', 'Search "oil"'];

    // Auto rotate hints every 2 seconds
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return false;
      setState(() {
        _currentIndex = (_currentIndex + 1) % _hints.length;
      });
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.searchPageBuilder != null
          ? () {
              final page = widget.searchPageBuilder!();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => page),
              );
                        }
          : null,
      child: Container(
        height: 40.h, // responsive height
        width: 1.sw, // full screen width
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300, width: 0.5.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search, color: Colors.grey.shade600, size: 22.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                _hints[_currentIndex],
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              height: 24.h,
              width: 1.w,
              color: Colors.grey.shade300,
            ),
            SizedBox(width: 8.w),
            SizedBox(
              height: 30.h, // adjust Lottie to search bar height
              width: 30.w,
              child: Lottie.asset(
                widget.lottieFile ?? AppLotteFiles.onboarding2,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
