// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgetpass_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPassResponse _$ForgotPassResponseFromJson(Map<String, dynamic> json) =>
    ForgotPassResponse(
      success: json['success'] as bool,
      data: ForgotPassModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForgotPassResponseToJson(ForgotPassResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
