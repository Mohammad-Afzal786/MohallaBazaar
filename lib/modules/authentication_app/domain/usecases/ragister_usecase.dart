import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/ragistar_result.dart';


import '../repositories/auth_repository.dart';

/// Business logic layer
class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<Either<Failure, RegisterResult>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
  }) {
    return repository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
    );
  }
}
