// lib/features/resetpassword/presentation/bloc/resetpassword_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/resetpassword_usecase.dart';
import 'resetpassword_event.dart';
import 'resetpassword_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase useCase;

  ResetPasswordBloc(this.useCase) : super(const ResetPasswordState()) {
    on<ResetPasswordSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(status: ResetPasswordStatus.loading, error: null));

    final result = await useCase(
        userId: event.userId,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword);

    result.fold(
      (failure) => emit(state.copyWith( message: failure.message,status: ResetPasswordStatus.failure, error: failure.message)),
      (data) => emit(state.copyWith( message: data.message,status: ResetPasswordStatus.success, data: data)),
    );
  }
}
