import 'package:json_annotation/json_annotation.dart';
import 'banner_model.dart';

part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponse {
  final String status;
  final String message;
  final List<BannerModel> banners;

  BannerResponse({
    required this.status,
    required this.message,
    required this.banners,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}
