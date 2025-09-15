import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/exceptions.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/datasources/auth_remote_datasource.dart';
import '../../domain/entities/login_result.dart';
import '../../domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, LoginResult>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remote.login(email, password);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }
}
