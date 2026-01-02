// lib/features/resetpassword/domain/usecases/resetpassword_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/repositories/auth_repository.dart';

import '../entities/resetpassword_result.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, ResetPasswordResult>> call({
    required String userId,
    required String newPassword,
    required String confirmPassword,
  }) {
    return repository.resetPassword(
        userId: userId, newPassword: newPassword, confirmPassword: confirmPassword);
  }
}
