import 'package:json_annotation/json_annotation.dart';

part 'forgatepass_request.g.dart';

@JsonSerializable()
class ForgotPassRequest {
  final String email;

  ForgotPassRequest({required this.email});

  factory ForgotPassRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPassRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPassRequestToJson(this);
}
