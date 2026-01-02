import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mohalla_bazaar/config/routes.dart';
import 'package:mohalla_bazaar/core/constants/app_theme.dart';
import 'package:mohalla_bazaar/auth_injection.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/login_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/ragistar_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/resetpassword_bloc.dart';
import 'package:mohalla_bazaar/modules/banner/presentation/bloc/banner_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_bloc.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_bloc.dart';
import 'package:mohalla_bazaar/modules/category_details/presentation/bloc/category_details_bloc.dart';
import 'package:mohalla_bazaar/modules/home_category_products/presentaton/bloc/home_category_products_bloc.dart';
import 'package:mohalla_bazaar/modules/notification/presentation/bloc/notification_bloc.dart';
import 'package:mohalla_bazaar/modules/order_now/presentation/bloc/order_bloc.dart';
import 'package:mohalla_bazaar/modules/orderhistory/presentation/bloc/orderhistory_bloc.dart';
import 'package:mohalla_bazaar/modules/parent_category/presentation/bloc/parent_category_bloc.dart';
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
            BlocProvider(create: (_) => sl<CartBloc>()),
            BlocProvider(create: (_) => sl<CartCountBloc>()),
            BlocProvider(create: (_) => sl<ViewCartBloc>()),
            BlocProvider(create: (_) => sl<OrderBloc>()),
            BlocProvider(create: (_) => sl<OrderHistoryBloc>()),
            BlocProvider(create: (_) => sl<NotificationBloc>()),
            BlocProvider(create: (_) => sl<HomeCategoryProductsBloc>()),
            BlocProvider(create: (_) => sl<BannerBloc>()),
          BlocProvider(create: (_) => sl<ParentCategoryBloc>()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Mohalla Bazaar",
            theme: AppTheme.lightTheme,
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.splash,
            getPages: AppRoutes.pages,
            useInheritedMediaQuery: true,
          ),
        );
      },
    );
  }
}
