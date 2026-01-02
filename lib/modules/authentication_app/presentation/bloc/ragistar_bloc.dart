import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/usecases/ragister_usecase.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/ragistar_event.dart';
import 'package:mohalla_bazaar/modules/authentication_app/presentation/bloc/ragister_state.dart';



/// ===============================
/// RegisterBloc
/// ===============================
/// Ye Bloc user ke register actions (events) ko handle karta hai
/// aur unke hisaab se naya state emit karta hai.
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(const RegisterState()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  /// ===============================
  /// Event Handler: _onRegisterSubmitted
  /// ===============================
  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    // Step 1: Loading state emit karo
    emit(state.copyWith(
      status: RegisterStatus.loading,
      error: null,
    ));

    // Step 2: RegisterUseCase call karo
    final result = await registerUseCase(
      name: event.name,
      password: event.password,
      phone: event.phone,
      fcmtoken:event.fcmtoken
    );

    // Step 3: Result handle karo
    result.fold(
      // ❌ Failure case
      (failure) => emit(
        state.copyWith(
          status: RegisterStatus.failure,
          error: failure.message,
        ),
      ),
      // ✅ Success case
      (data) => emit(
        state.copyWith(
          status: RegisterStatus.success,
          data: data,
        ),
      ),
    );
  }
}
