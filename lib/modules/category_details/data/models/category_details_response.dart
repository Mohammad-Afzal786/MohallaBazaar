import 'package:json_annotation/json_annotation.dart';
import 'category_details_model.dart';

part 'category_details_response.g.dart';

@JsonSerializable()
class CategoryDetailsResponse {
  final String status;
  final bool success;
  final String message;

  @JsonKey(name: "productData")
  final List<ProductModel> productData;

  CategoryDetailsResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.productData,
  });

  factory CategoryDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDetailsResponseToJson(this);
}
