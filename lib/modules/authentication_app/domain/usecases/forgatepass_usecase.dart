import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/forgatepass_result.dart';

import '../repositories/auth_repository.dart';

/// Business logic layer for Forgot Password
class ForgotPassUseCase {
  final AuthRepository repository;

  ForgotPassUseCase(this.repository);

  /// Call method to execute the use case
  Future<Either<Failure, ForgotPassResult>> call({
    required String phone,
  }) {
    return repository.forgotPass(phone: phone);
  }
}
