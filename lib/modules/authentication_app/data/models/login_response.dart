import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/login_result.dart';
import 'user_model.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  LoginResponse({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  /// API model → Entity (domain)
  LoginResult toEntity() => LoginResult(
        message: message,
        accessToken: accessToken,
        refreshToken: refreshToken,
        user: user.toEntity(),
      );
}
