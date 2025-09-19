import 'package:equatable/equatable.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/forgatepass_result.dart';

/// Process की सभी स्थितियाँ (state)
enum ForgotPassStatus { initial, loading, success, failure }

class ForgotPassState extends Equatable {
  final ForgotPassStatus status;
  final ForgotPassResult? data; // API से आया result
  final String? error;          // अगर fail हुआ तो error message

  const ForgotPassState({
    this.status = ForgotPassStatus.initial,
    this.data,
    this.error,
  });

  ForgotPassState copyWith({
    ForgotPassStatus? status,
    ForgotPassResult? data,
    String? error,
  }) {
    return ForgotPassState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, data, error];
}
