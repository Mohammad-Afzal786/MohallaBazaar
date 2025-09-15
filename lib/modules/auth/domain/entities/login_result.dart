import 'user.dart';

/// सिर्फ login API का response रखने के लिए
class LoginResult {
  final String message;
  final String accessToken;
  final String refreshToken;
  final User user;

  const LoginResult({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
}
