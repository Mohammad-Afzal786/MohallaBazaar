import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mohalla_bazaar/core/network/dio_client.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/datasources/auth_remote_datasource.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/repositories/auth_repository_impl.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/repositories/auth_repository.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/usecases/login_usecase.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/usecases/ragister_usecase.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/login_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/ragistar_bloc.dart';

final sl = GetIt.instance;

Future<void> initAuthInjection({required String baseUrl}) async {
  Dio dio = DioClient.create(baseUrl: baseUrl);

  final api = AuthApiService(dio, baseUrl: baseUrl);

  // ✅ Remote DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(api),
  );

  // ✅ Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // ✅ UseCases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));

  // ✅ Blocs
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl()));
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl()));
}
