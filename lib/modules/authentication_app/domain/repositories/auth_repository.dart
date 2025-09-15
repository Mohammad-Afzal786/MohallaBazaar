import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';

import '../entities/login_result.dart';

/// Contract (abstract class) → Data layer को implement करना होगा
abstract class AuthRepository {
  Future<Either<Failure, LoginResult>> login({
    required String email,
    required String password,
  });
}
