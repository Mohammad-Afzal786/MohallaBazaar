import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/config/routes.dart';
import 'package:mohalla_bazaar/core/constants/app_theme.dart';
import 'package:device_preview/device_preview.dart';

// DI locator

import 'package:mohalla_bazaar/auth_injection.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/login_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/ragistar_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/resetpassword_bloc.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_bloc.dart';
import 'package:mohalla_bazaar/modules/category_details/presentation/bloc/category_details_bloc.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/bloc/parent_category_details_bloc.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 804),
      minTextAdapt: true,
      builder: (context, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<LoginBloc>()),
            BlocProvider(create: (_) => sl<RegisterBloc>()),
            BlocProvider(create: (_) => sl<ForgotPassBloc>()),
            BlocProvider(create: (_) => sl<ResetPasswordBloc>()),
             BlocProvider(create: (_) => sl<CategoriesBloc>()),
              BlocProvider(create: (_) => sl<ParentCategoryDetailsBloc>()),
               BlocProvider(create: (_) => sl<CategoryDetailsBloc>()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Mohalla Bazaar",
            
            theme: AppTheme.lightTheme,
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.splash,
            getPages: AppRoutes.pages,
            useInheritedMediaQuery: true,
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.locale(context),
            
          ),
        );
      },
    );
  }
}
