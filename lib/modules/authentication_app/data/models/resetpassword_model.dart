// lib/features/resetpassword/data/models/resetpassword_model.dart

import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/resetpassword_entity.dart';

part 'resetpassword_model.g.dart';

@JsonSerializable()
class ResetPasswordModel {
  final String message;

  ResetPasswordModel({required this.message});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordModelToJson(this);

  ResetPasswordEntity toEntity() => ResetPasswordEntity(message: message);
}
