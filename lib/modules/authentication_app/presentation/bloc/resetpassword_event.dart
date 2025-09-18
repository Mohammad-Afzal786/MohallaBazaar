// lib/features/resetpassword/presentation/bloc/resetpassword_event.dart

import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

/// Event जब user form submit करता है
class ResetPasswordSubmitted extends ResetPasswordEvent {
  final String userId;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordSubmitted({
    required this.userId,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [userId, newPassword, confirmPassword];
}
