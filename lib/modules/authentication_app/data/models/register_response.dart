import 'package:json_annotation/json_annotation.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/ragistar_result.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String message;
   final String name;
  final String phone;
  final String fcmtoken;
  final String userId; // Agar API sirf userId return karta hai

  // Agar API login tokens bhi return karta hai, add karein:
  // final String accessToken;
  // final String refreshToken;

  RegisterResponse({
    required this.message,
    required this.userId,
    required this.name,
    required this.phone,
    required this.fcmtoken,
    // this.accessToken,
    // this.refreshToken,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);

  
   RegisterResult toEntity() => RegisterResult(
  message: message,
  userId: userId,
  name: name,
  phone: phone,
  fcmtoken: fcmtoken,
);

}
