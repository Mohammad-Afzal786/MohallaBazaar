import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/ragistar_result.dart';


import '../repositories/auth_repository.dart';

/// Business logic layer
class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<Either<Failure, RegisterResult>> call({
    required String name,
    required String password,
    required String phone,
    required String fcmtoken,
  }) {
    return repository.register(
      name: name,
      password: password,
      phone: phone,
      fcmtoken:fcmtoken
    );
  }
}
