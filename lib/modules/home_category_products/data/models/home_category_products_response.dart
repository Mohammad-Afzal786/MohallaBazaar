import 'package:json_annotation/json_annotation.dart';
import 'home_category_products_model.dart';

part 'home_category_products_response.g.dart';

@JsonSerializable()
class HomeCategoryProductsResponse {
  final bool success;
  final String message;
  final List<HomeCategoryProductsModel> data;

  HomeCategoryProductsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HomeCategoryProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeCategoryProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeCategoryProductsResponseToJson(this);
}
