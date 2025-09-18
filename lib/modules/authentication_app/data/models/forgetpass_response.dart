import 'package:json_annotation/json_annotation.dart';
import 'package:mohalla_bazaar/modules/authentication_app/data/models/forgetpass_model.dart';
import 'package:mohalla_bazaar/modules/authentication_app/domain/entities/forgatepass_result.dart';

part 'forgetpass_response.g.dart'; // ✅ exact filename match होना चाहिए


@JsonSerializable()
class ForgotPassResponse {
 final bool success;
 final ForgotPassModel data;

ForgotPassResponse({
required this.success,
required this.data,
});

factory ForgotPassResponse.fromJson(Map<String, dynamic> json) =>
_$ForgotPassResponseFromJson(json);

Map<String, dynamic> toJson() => _$ForgotPassResponseToJson(this);
/// API model → Entity (domain)
  ForgotPassResult toEntity() => ForgotPassResult(
          success: success , // String ko bool convert karo
          data: data.toEntity(),
      );
}