import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/forgatepass_result.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/ragistar_result.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/resetpassword_result.dart';

import '../entities/login_result.dart';

/// Contract (abstract class) → Data layer को implement करना होगा
abstract class AuthRepository {
  Future<Either<Failure, LoginResult>> login({
    required String email,
    required String password,
    required String fcmtoken,
  });

    Future<Either<Failure, RegisterResult>> register({   // ✅ New
    required String name,
    required String password,
    required String phone,
    required String fcmtoken,
  });

  Future<Either<Failure, ForgotPassResult>> forgotPass({
   required String phone,
  });

  Future<Either<Failure, ResetPasswordResult>> resetPassword({
    required String userId,
    required String newPassword,
    required String confirmPassword,
  });
}
