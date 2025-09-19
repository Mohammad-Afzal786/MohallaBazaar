// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgetpass_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPassModel _$ForgotPassModelFromJson(Map<String, dynamic> json) =>
    ForgotPassModel(
      message: json['message'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$ForgotPassModelToJson(ForgotPassModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'userId': instance.userId,
    };
