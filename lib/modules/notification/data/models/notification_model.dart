class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String image;
  final bool read;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.image,
    required this.read,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      image: json['image'] ?? '',
      read: json['read'] ?? false,
      createdAt: (json['createdAt']),
    );
  }

 
}
