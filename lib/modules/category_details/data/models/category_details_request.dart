import 'package:json_annotation/json_annotation.dart';

part 'category_details_request.g.dart';

@JsonSerializable()
class CategoryDetailsRequest {
  final String categoryId;

  CategoryDetailsRequest({required this.categoryId});

  factory CategoryDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDetailsRequestToJson(this);
}
