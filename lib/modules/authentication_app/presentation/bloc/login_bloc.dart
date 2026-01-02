import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

/// ===============================
/// LoginBloc
/// ===============================
/// Bloc = Business Logic Component
/// 👉 यह Bloc user के login actions (events) को handle करता है,
/// और उनके हिसाब से नया state (UI की current स्थिति) emit करता है।
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// Bloc के अंदर login करने के लिए
  /// हमें UseCase की जरूरत है (Clean Architecture rule)
  /// 👉 Bloc सीधे API call नहीं करता।
  /// LoginUseCase dependency injection से पास किया गया है।
  final LoginUseCase loginUseCase;

  /// Constructor
  /// super(const LoginState()) → Bloc का initial state सेट करता है (initial)
  /// on LoginSubmitted (_onLoginSubmitted) →
  /// Bloc को बताता है कि अगर "LoginSubmitted" event आएगा,
  /// तो उसे "_onLoginSubmitted" method से handle करो।
  LoginBloc(this.loginUseCase) : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  /// ===============================
  /// Event Handler: _onLoginSubmitted
  /// ===============================
  /// यह function तब call होगा जब UI से LoginSubmitted event आएगा।
  /// e.g. User ने email+password भरकर login button दबाया।
  Future<void> _onLoginSubmitted(
    LoginSubmitted event,     // Event object: इसमें user का email और password होता है
    Emitter<LoginState> emit, // emit() = नया state भेजने का तरीका
  ) async {
    // Step 1: सबसे पहले UI को बताओ कि "loading" चल रहा है।
    // ताकि UI spinner/progress bar दिखा सके।
    emit(state.copyWith(
      status: LoginStatus.loading,
      error: null,   // error reset कर दिया ताकि पुराना error न दिखे
    ));

    // Step 2: LoginUseCase call करो (actual login logic यहाँ होगा)
    // 👉 loginUseCase API call करेगा और result देगा।
    // Result का type है: Either<Failure, LoginResult>
    final result = await loginUseCase(
      email: event.phone,      // event से आया email
      password: event.password ,// event से आया password
      fcmtoken: event.fcmtoken
    );

    // Step 3: Result handle करो
    // fold() = functional तरीका है result को handle करने का।
    // Either type हमेशा दो possibilities देता है:
    // - Left  = Failure (error case)
    // - Right = Data (success case)
    result.fold(
      // ❌ अगर Failure मिला (जैसे network error, wrong password, server error):
      (failure) => emit(
        state.copyWith(
          status: LoginStatus.failure,  // state को failure में बदल दिया
          error: failure.message,       // UI को दिखाने के लिए error message पास किया
        ),
      ),

      // ✅ अगर Success मिला (login successful, data मिला):
      (data) => emit(
        state.copyWith(
          status: LoginStatus.success, // state को success में बदल दिया
          data: data,                  // data (LoginResult object) UI को पास किया
        ),
      ),
    );
  }
}
