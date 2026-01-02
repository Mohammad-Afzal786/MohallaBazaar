import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/exceptions.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/datasources/auth_remote_datasource.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/forgatepass_result.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/ragistar_result.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/resetpassword_result.dart';
import '../../domain/entities/login_result.dart';
import '../../domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, LoginResult>> login({
    required String email,
    required String password,
    required String fcmtoken,
  }) async {
    try {
      final response = await remote.login(email, password,fcmtoken);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

   @override
  Future<Either<Failure, RegisterResult>> register({
    required String name,
    required String password,
    required String phone,
      required String fcmtoken,
  }) async {
    try {
      final response = await remote.register(
        name,
        password,
        phone,
        fcmtoken
      );

      // ✅ Agar API se sirf message aata hai
      return Right(response.toEntity());

      // ✅ Agar API se tokens/user bhi aate hain:
      // return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

   /// =========================
  /// Forgot Password
  /// =========================
  @override
  Future<Either<Failure, ForgotPassResult>> forgotPass({
    required String phone,
  }) async {
    try {
      final response = await remote.forgotPass(phone);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }


  @override
  Future<Either<Failure, ResetPasswordResult>> resetPassword({
    required String userId,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await remote.resetPassword(userId, newPassword, confirmPassword);
      return Right(response.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }
}
