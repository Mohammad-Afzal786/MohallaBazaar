// lib/features/resetpassword/domain/entities/resetpassword_result.dart

import 'resetpassword_entity.dart';

/// Reset Password API result
class ResetPasswordResult {
  final bool success;
   final String message;
  final ResetPasswordEntity data;

  const ResetPasswordResult({
    required this.success, 
     required this.message, 
     required this.data
  });
}
