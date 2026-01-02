import 'notification_model.dart';

class NotificationResponse {
  final String status;
  final String message;
  final List<NotificationModel> notifications;

  NotificationResponse({
    required this.status,
    required this.message,
    required this.notifications,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map((e) => NotificationModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
