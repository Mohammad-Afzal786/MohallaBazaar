import 'package:equatable/equatable.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/login_result.dart';

/// ===============================
/// LoginStatus Enum
/// ===============================
/// Enum का मतलब है "संभव स्थितियों की लिस्ट"
/// Login process में सिर्फ 4 ही हालात हो सकते हैं:
/// 1. initial  → शुरुआत में, user ने कुछ नहीं किया
/// 2. loading  → Login request चल रही है (waiting)
/// 3. success  → Login सफल हुआ (user को data मिला)
/// 4. failure  → Login fail हुआ (error आया)
///
/// Example: सोचो canteen में बच्चा खड़ा है
/// - initial = बच्चा counter पर खड़ा है
/// - loading = दुकानदार समोसा पैक कर रहा है
/// - success = बच्चा समोसा खा रहा है 😋
/// - failure = दुकानदार बोला "समोसा खत्म हो गया"
enum LoginStatus { initial, loading, success, failure }

/// ===============================
/// LoginState Class
/// ===============================
/// State = UI का "current हाल"
/// Bloc हर बार नया state emit करेगा और UI उसी के हिसाब से बदलेगा।
class LoginState extends Equatable {
    /// अभी की स्थिति (initial/loading/success/failure)
  final LoginStatus status;
  /// अगर login successful हुआ तो data आएगा
  /// जैसे server से मिला token या user info
  final LoginResult? data;
    /// अगर login fail हुआ तो यहाँ error message store होगा
  final String? error;
 /// Constructor
  /// Default status = initial (मतलब शुरुआत में form खाली है)
  const LoginState({
    this.status = LoginStatus.initial,
    this.data,
    this.error,
  });
  /// copyWith Method
  /// State immutable (बदला नहीं जा सकता) होता है
  /// नया state बनाने के लिए copyWith का use करते हैं
  /// Example:
  ///   state.copyWith(status: LoginStatus.loading)
  /// इसका मतलब:
  ///   नया state बनाओ जिसमें सिर्फ status बदला हो,
  ///   बाकी values (data, error) same रहें।
  LoginState copyWith({
    LoginStatus? status,
    LoginResult? data,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status, // अगर नया status नहीं दिया तो पुराना ही use होगा
      data: data ?? this.data,       // success data
      error: error,  // नया error override करेगा (null भी हो सकता है)
    );
  }
  /// Equatable का फायदा:
  /// दो states को compare करना आसान हो जाता है
  /// e.g. अगर status, data, error same हैं तो दोनों states equal होंगे
  @override
  List<Object?> get props => [status, data, error];
}
