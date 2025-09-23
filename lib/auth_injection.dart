import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mohalla_bazaar/core/network/api_client.dart';
import 'package:mohalla_bazaar/core/network/dio_client.dart';

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

  // ========================= AUTHENTICATION =========================
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(api),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerLazySingleton<ForgotPassUseCase>(() => ForgotPassUseCase(sl()));
  sl.registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(sl()));

  sl.registerFactory<LoginBloc>(() => LoginBloc(sl()));
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl()));
  sl.registerFactory<ForgotPassBloc>(() => ForgotPassBloc(sl()));
  sl.registerFactory<ResetPasswordBloc>(() => ResetPasswordBloc(sl()));

  // ========================= CATEGORY =========================
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
      () => CategoriesRemoteDataSourceImpl(api));
  sl.registerLazySingleton<CategoriesLocalDataSource>(
      () => CategoriesLocalDataSourceImpl());

  sl.registerLazySingleton<CategoriesRepository>(() => CategoriesRepositoryImpl(
        remote: sl(),
        local: sl(),
      ));

  sl.registerLazySingleton<GetCategoriesUseCase>(() => GetCategoriesUseCase(sl()));
  sl.registerFactory<CategoriesBloc>(() => CategoriesBloc(sl()));

 
  // ========================= PARENT CATEGORY DETAILS =========================
  sl.registerLazySingleton<ParentCategoryDetailsRemoteDataSource>(
      () => ParentCategoryDetailsRemoteDataSourceImpl(api));
  sl.registerLazySingleton<ParentCategoryDetailsLocalDataSource>(
      () => ParentCategoryDetailsLocalDataSourceImpl());

  sl.registerLazySingleton<ParentCategoryDetailsRepository>(() =>
      ParentCategoryDetailsRepositoryImpl(
          remote: sl(), local: sl()));

  sl.registerLazySingleton<ParentCategoryDetailsUseCase>(
      () => ParentCategoryDetailsUseCase(sl()));

  sl.registerFactory(() => ParentCategoryDetailsBloc(sl()));







  // DataSources
  sl.registerLazySingleton<CategoryDetailsRemoteDataSource>(
      () => CategoryDetailsRemoteDataSourceImpl(api));
  sl.registerLazySingleton<CategoryDetailsLocalDataSource>(
      () => CategoryDetailsLocalDataSourceImpl());

  // Repository
  sl.registerLazySingleton<CategoryDetailsRepository>(
      () => CategoryDetailsRepositoryImpl(
            remote: sl(),
            local: sl(),
          ));

  // UseCase
  sl.registerLazySingleton<CategoryDetailsUseCase>(
      () => CategoryDetailsUseCase(sl()));

  // Bloc
  sl.registerFactory<CategoryDetailsBloc>(() => CategoryDetailsBloc(sl()));
}
