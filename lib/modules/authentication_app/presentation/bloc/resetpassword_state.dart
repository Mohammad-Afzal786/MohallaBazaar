// lib/features/resetpassword/presentation/bloc/resetpassword_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/resetpassword_result.dart';

enum ResetPasswordStatus { initial, loading, success, failure }

class ResetPasswordState extends Equatable {
  final ResetPasswordStatus status;
  final ResetPasswordResult? data;
  final String? error;
  final String? message; // 👈 API ka message yahan store hoga

  const ResetPasswordState({this.status = ResetPasswordStatus.initial, this.data, this.error,this.message});

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    ResetPasswordResult? data,
    String? error,
     String? message,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, data, error,message];
}
