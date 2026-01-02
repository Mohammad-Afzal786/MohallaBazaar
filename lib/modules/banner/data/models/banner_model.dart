import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {

  final String imageUrl;
  final String count;
  final String createdAt;

  BannerModel({

    required this.imageUrl,
    required this.count,
    required this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
