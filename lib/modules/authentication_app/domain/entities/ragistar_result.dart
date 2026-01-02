class RegisterResult {
  final String message;
  final String userId;
  final String name;
  final String phone;
  final String fcmtoken;

  RegisterResult({
    required this.message,
    required this.userId,
    required this.name,
    required this.phone,
    required this.fcmtoken,
  });
}
