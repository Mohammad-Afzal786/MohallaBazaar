import 'package:dartz/dartz.dart';

import 'package:mohalla_bazaar/core/errors/failures.dart';

import '../entities/login_result.dart';
import '../repositories/auth_repository.dart';

/// Business logic layer
class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<Either<Failure, LoginResult>> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
