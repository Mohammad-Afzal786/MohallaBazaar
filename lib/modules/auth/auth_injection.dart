import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mohalla_bazaar/core/network/dio_client.dart';
import 'package:mohalla_bazaar/modules/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mohalla_bazaar/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:mohalla_bazaar/modules/auth/domain/repositories/auth_repository.dart';
import 'package:mohalla_bazaar/modules/auth/domain/usecases/login_usecase.dart';
import 'package:mohalla_bazaar/modules/auth/presentation/bloc/login_bloc.dart';

final sl = GetIt.instance;

Future<void> initAuthInjection({required String baseUrl}) async {
  Dio dio = DioClient.create(baseUrl: baseUrl);

  final api = AuthApiService(dio, baseUrl: baseUrl);

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(api),
  );

  // ✅ Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // ✅ UseCase
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

  // ✅ Bloc
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl()));
}
