import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequest {
  final String userId;
  final String useraddress;
  OrderRequest({required this.userId,required this.useraddress});

  factory OrderRequest.fromJson(Map<String, dynamic> json) => _$OrderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}
