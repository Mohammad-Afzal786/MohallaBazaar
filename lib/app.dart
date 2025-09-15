import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/config/routes.dart';
import 'package:mohalla_bazaar/core/constants/app_theme.dart';
import 'package:device_preview/device_preview.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 804),
      minTextAdapt: true,
      builder: (context, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Mohalla Bazaar",
          // ✅ Theme
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.system,
          // ✅ Routes
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.pages,
          useInheritedMediaQuery: true,
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
        );
      },
    );
  }
}
