import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/usecases/forgatepass_usecase.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_event.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/forgatepass_state.dart';



/// ===============================
/// ForgotPassBloc
/// ===============================
/// Bloc user के forgot password events को handle करेगा
/// और नया state emit करेगा
class ForgotPassBloc extends Bloc<ForgotPassEvent, ForgotPassState> {
  final ForgotPassUseCase forgotPassUseCase;

  ForgotPassBloc(this.forgotPassUseCase) : super(const ForgotPassState()) {
    on<ForgotPassSubmitted>(_onForgotPassSubmitted);
  }

  Future<void> _onForgotPassSubmitted(
    ForgotPassSubmitted event,
    Emitter<ForgotPassState> emit,
  ) async {
    // Step 1: loading state emit करो
    emit(state.copyWith(
      status: ForgotPassStatus.loading,
      error: null,
    ));

    // Step 2: usecase call करो
    final result = await forgotPassUseCase(phone: event.phone);

    // Step 3: result handle करो
    result.fold(
      // Failure case
      (failure) => emit(
        state.copyWith(
          status: ForgotPassStatus.failure,
          error: failure.message,
        ),
      ),

      // Success case
      (data) => emit(
        state.copyWith(
          status: ForgotPassStatus.success,
          data: data,
        ),
      ),
    );
  }
}
