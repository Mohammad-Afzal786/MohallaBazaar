import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/forgetpassentity.dart';

part 'forgetpass_model.g.dart';

@JsonSerializable()
class ForgotPassModel {
  final String message;
  final String userId;

  ForgotPassModel({required this.message, required this.userId});

  factory ForgotPassModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPassModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPassModelToJson(this);
  
  ForgetpassEntity toEntity() => ForgetpassEntity(
        message: message,
        userId: userId,
      );
}
