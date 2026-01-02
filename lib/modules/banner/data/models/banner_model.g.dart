// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      imageUrl: json['imageUrl'] as String,
      count: json['count'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'count': instance.count,
      'createdAt': instance.createdAt,
    };
