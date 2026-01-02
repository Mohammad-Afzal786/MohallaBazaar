import 'parent_category_model.dart';

class ParentCategoryResponse {
  final String status;
  final String message;
  final List<ParentCategoryModel> data;

  ParentCategoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  /// Parse JSON from API
  factory ParentCategoryResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['data'] ?? [];
    return ParentCategoryResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: list.map((e) => ParentCategoryModel.fromJson(e)).toList(),
    );
  }

  /// Convert back to JSON (optional, for API or debug)
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  /// Helper to get the list for caching or local storage
  List<ParentCategoryModel> get cachedList => data;
}
