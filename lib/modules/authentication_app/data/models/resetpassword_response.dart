// lib/features/resetpassword/data/models/resetpassword_response.dart

import 'package:json_annotation/json_annotation.dart';
import 'resetpassword_model.dart';
import '../../domain/entities/resetpassword_result.dart';

part 'resetpassword_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  final bool success;
  final String message;
  final ResetPasswordModel data;

  ResetPasswordResponse({required this.success, required this.data,required this.message});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);

  ResetPasswordResult toEntity() => ResetPasswordResult(
    success: success,
    data: data.toEntity(),
    message: message,
  );
}
