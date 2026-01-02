// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resetpassword_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequest _$ResetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordRequest(
      userId: json['userId'] as String,
      newPassword: json['newPassword'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$ResetPasswordRequestToJson(
        ResetPasswordRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };
