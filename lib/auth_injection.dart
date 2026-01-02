import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mohalla_bazaar/core/network/api_client.dart';
import 'package:mohalla_bazaar/core/network/dio_client.dart';
import 'package:mohalla_bazaar/core/network/sqlite_client.dart';

// Authentication
import 'package:mohalla_bazaar/modules/authentication_app/data/datasources/auth_remote_datasource.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/repositories/auth_repository_impl.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/repositories/auth_repository.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/usecases/forgatepass_usecase.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/usecases/login_usecase.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/usecases/ragister_usecase.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/usecases/resetpassword_usecase.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/login_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/ragistar_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/resetpassword_bloc.dart';
import 'package:mohalla_bazaar/modules/banner/data/datasources/banner_local_data_source.dart';
import 'package:mohalla_bazaar/modules/banner/data/datasources/banner_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/banner/data/repositories/banner_repository_impl.dart';
import 'package:mohalla_bazaar/modules/banner/domain/repositories/banner_repository.dart';
import 'package:mohalla_bazaar/modules/banner/domain/usecases/get_banners_usecase.dart';
import 'package:mohalla_bazaar/modules/banner/presentation/bloc/banner_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/data/datasources/cart_item_local_data_source.dart';
import 'package:mohalla_bazaar/modules/cart/data/datasources/cart_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/cart/data/datasources/viewcart_local_data_source.dart';
import 'package:mohalla_bazaar/modules/cart/data/datasources/viewcart_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/cart/data/repositories/cart_repository_impl.dart';
import 'package:mohalla_bazaar/modules/cart/data/repositories/viewcart_repository_impl.dart';
import 'package:mohalla_bazaar/modules/cart/domain/repositories/cart_repository.dart';
import 'package:mohalla_bazaar/modules/cart/domain/repositories/viewcart_repository.dart';
import 'package:mohalla_bazaar/modules/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:mohalla_bazaar/modules/cart/domain/usecases/get_cart_count_usecase.dart';
import 'package:mohalla_bazaar/modules/cart/domain/usecases/viewcart_usecase.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cart_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/cartcount_bloc.dart';
import 'package:mohalla_bazaar/modules/cart/presentation/bloc/viewcart_bloc.dart';

// Category
import 'package:mohalla_bazaar/modules/category/data/datasources/categories_local_data_source.dart';
import 'package:mohalla_bazaar/modules/category/data/datasources/categories_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/category/data/repositories/categories_repository_impl.dart';
import 'package:mohalla_bazaar/modules/category/domain/repositories/categories_repository.dart';
import 'package:mohalla_bazaar/modules/category/domain/usecases/get_categories_usecase.dart';
import 'package:mohalla_bazaar/modules/category/presentation/bloc/categories_bloc.dart';
import 'package:mohalla_bazaar/modules/category_details/data/datasources/category_details_local_data_source.dart';
import 'package:mohalla_bazaar/modules/category_details/data/datasources/category_details_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/category_details/data/repositories/category_details_repository_impl.dart';
import 'package:mohalla_bazaar/modules/category_details/domain/repositories/category_details_repository.dart';
import 'package:mohalla_bazaar/modules/category_details/domain/usecases/category_details_usecase.dart';
import 'package:mohalla_bazaar/modules/category_details/presentation/bloc/category_details_bloc.dart';
import 'package:mohalla_bazaar/modules/home_category_products/data/datasources/home_category_products_local_data_source.dart';
import 'package:mohalla_bazaar/modules/home_category_products/data/datasources/home_category_products_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/home_category_products/data/repositories/home_category_products_repository_impl.dart';
import 'package:mohalla_bazaar/modules/home_category_products/domain/repositories/home_category_products_repository.dart';
import 'package:mohalla_bazaar/modules/home_category_products/domain/usecases/get_home_category_products_usecase.dart';
import 'package:mohalla_bazaar/modules/home_category_products/presentaton/bloc/home_category_products_bloc.dart';
import 'package:mohalla_bazaar/modules/notification/data/datasources/notification_local_data_source.dart.dart';
import 'package:mohalla_bazaar/modules/notification/data/datasources/notification_remote_data_source.dart.dart';
import 'package:mohalla_bazaar/modules/notification/data/repositories/notification_repository_impl.dart';
import 'package:mohalla_bazaar/modules/notification/domain/repositories/notification_repository.dart';
import 'package:mohalla_bazaar/modules/notification/domain/usecases/get_notifications_usecase.dart';
import 'package:mohalla_bazaar/modules/notification/presentation/bloc/notification_bloc.dart';
import 'package:mohalla_bazaar/modules/order_now/data/datasources/order_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/order_now/data/repositories/order_repository_impl.dart';
import 'package:mohalla_bazaar/modules/order_now/domain/repositories/order_repository.dart';
import 'package:mohalla_bazaar/modules/order_now/domain/usecases/place_order_usecase.dart';
import 'package:mohalla_bazaar/modules/order_now/presentation/bloc/order_bloc.dart';
import 'package:mohalla_bazaar/modules/orderhistory/data/datasources/orderhistory_local_data_source.dart';
import 'package:mohalla_bazaar/modules/orderhistory/data/datasources/orderhistory_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/orderhistory/data/repositories/orderhistory_repository_impl.dart';
import 'package:mohalla_bazaar/modules/orderhistory/domain/repositories/orderhistory_repository.dart';
import 'package:mohalla_bazaar/modules/orderhistory/domain/usecases/orderhistory_usecase.dart';
import 'package:mohalla_bazaar/modules/orderhistory/presentation/bloc/orderhistory_bloc.dart';
import 'package:mohalla_bazaar/modules/parent_category/data/datasources/parent_category_local_data_source.dart';
import 'package:mohalla_bazaar/modules/parent_category/data/datasources/parent_category_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/parent_category/data/repositories/parent_category_repository_impl.dart';
import 'package:mohalla_bazaar/modules/parent_category/domain/usecases/parent_category_usecase.dart';
import 'package:mohalla_bazaar/modules/parent_category/presentation/bloc/parent_category_bloc.dart';

// Parent Category Details
import 'package:mohalla_bazaar/modules/parent_category_details/data/datasources/parent_categorydetails_local_data_source.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/data/datasources/parent_categorydetails_remote_data_source.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/data/repositories/parent_categorydetails_repository_impl.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/repositories/parent_categorydetails_repository.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/usecases/parent_categorydetails_usecase.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/presentation/bloc/parent_category_details_bloc.dart';

final sl = GetIt.instance;

Future<void> initInjection({required String baseUrl}) async {
  Dio dio = DioClient.create(baseUrl: baseUrl);

  final api = ApiClient(dio, baseUrl: baseUrl);
   // ✅ ये दो lines add करो
  sl.registerLazySingleton<Dio>(() => dio);
  sl.registerLazySingleton<ApiClient>(() => api);
  // ✅ Register Isar instance in GetIt
// 🔹 नया (SQLiteHelper class या DB provider)
sl.registerLazySingleton<SQLiteClient>(() => SQLiteClient());


  // ========================= AUTHENTICATION =========================
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(api),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<ForgotPassUseCase>(() => ForgotPassUseCase(sl()));
  sl.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(sl()),
  );

  sl.registerFactory<LoginBloc>(() => LoginBloc(sl()));
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl()));
  sl.registerFactory<ForgotPassBloc>(() => ForgotPassBloc(sl()));
  sl.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc(sl()));

  // ========================= CATEGORY =========================
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(api),
  );
  sl.registerLazySingleton<CategoriesLocalDataSource>(
    () => CategoriesLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(remote: sl(), local: sl()),
  );

  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl()),
  );
  sl.registerFactory<CategoriesBloc>(() => CategoriesBloc(sl()));

  // ========================= PARENT CATEGORY DETAILS =========================
  sl.registerLazySingleton<ParentCategoryDetailsRemoteDataSource>(
    () => ParentCategoryDetailsRemoteDataSourceImpl(api),
  );
  sl.registerLazySingleton<ParentCategoryDetailsLocalDataSource>(
    () => ParentCategoryDetailsLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ParentCategoryDetailsRepository>(
    () => ParentCategoryDetailsRepositoryImpl(remote: sl(), local: sl()),
  );

  sl.registerLazySingleton<ParentCategoryDetailsUseCase>(
    () => ParentCategoryDetailsUseCase(sl()),
  );

  sl.registerFactory(() => ParentCategoryDetailsBloc(sl()));

  // DataSources
  sl.registerLazySingleton<CategoryDetailsRemoteDataSource>(
    () => CategoryDetailsRemoteDataSourceImpl(api),
  );
  sl.registerLazySingleton<CategoryDetailsLocalDataSource>(
    () => CategoryDetailsLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<CategoryDetailsRepository>(
    () => CategoryDetailsRepositoryImpl(remote: sl(), local: sl()),
  );

  // UseCase
  sl.registerLazySingleton<CategoryDetailsUseCase>(
    () => CategoryDetailsUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<CategoryDetailsBloc>(() => CategoryDetailsBloc(sl()));

  // ========================= CART =========================
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSource(api),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(remote: sl(), local: sl()),
  );

  sl.registerLazySingleton<AddToCartUseCase>(() => AddToCartUseCase(sl()));

  sl.registerFactory<CartBloc>(() => CartBloc(sl()));



  // ========================= CART COUNT =========================


// ========================= CART COUNT =========================

// Remote


// Local
// Local
// Local
sl.registerLazySingleton<CartLocalDataSource>(
  () => CartLocalDataSource(), // अब constructor में DB instance नहीं चाहिए
);



// UseCase
sl.registerLazySingleton<GetCartCountUseCase>(
  () => GetCartCountUseCase(sl()),
);



sl.registerFactory<CartCountBloc>(
  () => CartCountBloc(
    sl<GetCartCountUseCase>(),   // 1️⃣ UseCase
    sl<CartLocalDataSource>(),   // 2️⃣ Local DataSource
  ),
);






 // Data sources
  sl.registerLazySingleton<ViewCartRemoteDataSource>(() => ViewCartRemoteDataSourceImpl(api));
  sl.registerLazySingleton<ViewCartLocalDataSource>(() => ViewCartLocalDataSourceImpl());

  // Repository
  sl.registerLazySingleton<ViewCartRepository>(() => ViewCartRepositoryImpl(
        remote: sl(),
        local: sl(),
      ));

  // Usecase
  sl.registerLazySingleton<ViewCartUseCase>(() => ViewCartUseCase(sl()));

  // Bloc
  sl.registerFactory(() => ViewCartBloc(sl()));


  sl.registerLazySingleton<OrderRemoteDataSource>(() => OrderRemoteDataSourceImpl(api));
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));
  sl.registerLazySingleton(() => PlaceOrderUseCase(sl()));
  sl.registerFactory(() => OrderBloc(sl()));


    // ========================= ORDER HISTORY =========================
  sl.registerLazySingleton<OrderHistoryRemoteDataSource>(
    () => OrderHistoryRemoteDataSourceImpl(api),
  );
  sl.registerLazySingleton<OrderHistoryLocalDataSource>(
    () => OrderHistoryLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<OrderHistoryRepository>(
    () => OrderHistoryRepositoryImpl(
      remote: sl(),
      local: sl(),
    ),
  );

  sl.registerLazySingleton<GetOrderHistoryUseCase>(
    () => GetOrderHistoryUseCase(sl()),
  );

  sl.registerFactory<OrderHistoryBloc>(
    () => OrderHistoryBloc(sl()),
  );



sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(sl()));

sl.registerLazySingleton<NotificationLocalDataSource>(
    () => NotificationLocalDataSourceImpl(sl()));

sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(remote: sl(), local: sl()));

sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));

sl.registerFactory(() => NotificationBloc(sl()));





 // 🔹 Data Sources
  sl.registerLazySingleton<HomeCategoryProductsRemoteDataSource>(
      () => HomeCategoryProductsRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<HomeCategoryProductsLocalDataSource>(
      () => HomeCategoryProductsLocalDataSourceImpl());

  // 🔹 Repository
  sl.registerLazySingleton(() => HomeCategoryProductsRepositoryImpl(
        remote: sl(),
        local: sl(),
      ));

  // 🔹 UseCase
  sl.registerLazySingleton(() => GetHomeCategoryProductsUseCase(sl()));

  // 🔹 Bloc
  sl.registerFactory(() => HomeCategoryProductsBloc(sl()));
  // 🔹 Repository
sl.registerLazySingleton<HomeCategoryProductsRepository>(
  () => HomeCategoryProductsRepositoryImpl(
        remote: sl(),
        local: sl(),
      ),
);



// Data sources
  sl.registerLazySingleton<BannerRemoteDataSource>(() => BannerRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<BannerLocalDataSource>(() => BannerLocalDataSourceImpl());

 
  // Repository
  sl.registerLazySingleton(() => BannerRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));

  // UseCase
  sl.registerLazySingleton(() => GetBannersUseCase(sl()));

  // Bloc
  sl.registerFactory(() => BannerBloc(sl()));
  sl.registerLazySingleton<BannerRepository>(
  () => BannerRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ),
);










// Data sources
  sl.registerLazySingleton<ParentCategoryLocalDataSource>(() => ParentCategoryLocalDataSourceImpl());
  sl.registerLazySingleton<ParentCategoryRemoteDataSource>(() => ParentCategoryRemoteDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton(() => ParentCategoryRepositoryImpl(local: sl(), remote: sl()));

  // UseCase
  sl.registerLazySingleton(() => ParentCategoryUseCase(sl()));

  // Bloc
  sl.registerFactory(() => ParentCategoryBloc(sl()));
}
