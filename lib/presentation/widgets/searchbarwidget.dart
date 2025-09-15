import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mohalla_bazaar/core/constants/app_lotte_files.dart';
import 'package:mohalla_bazaar/core/utils/nav_helper.dart';

class SearchBarWidget extends StatefulWidget {
  final List<String>? hints;
  final String? lottieFile;
  final Widget Function()? searchPageBuilder;
  // Page बनाने का callback (कोई query पास करने की ज़रूरत नहीं अब)

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

    // Auto rotate hints
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
      onTap: () {
      
          NavHelper.goToproductsseach();
        
      },
      child: Container(
        height: 42,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey.shade600, size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _hints[_currentIndex],
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          
              Container(height: 24, width: 1, color: Colors.grey.shade300),
              const SizedBox(width: 8),
              Lottie.asset( AppLotteFiles.onboarding2, height: 0.45.sh, fit: BoxFit.contain, ),
            
          ],
        ),
      ),
    );
  }
}
