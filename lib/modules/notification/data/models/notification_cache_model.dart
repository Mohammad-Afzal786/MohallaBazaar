
class NotificationCacheModel {
  final String id;
  final String title;
  final String message;
  final String image;
  final bool read;
  final String createdAt;

  NotificationCacheModel({
    required this.id,
    required this.title,
    required this.message,
    required this.image,
    required this.read,
    required this.createdAt,
  });

  factory NotificationCacheModel.fromMap(Map<String, dynamic> map) {
    return NotificationCacheModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      image: map['image'] ?? '',
      read: map['read'] == 1,
      createdAt: (map['createdAt']),
  
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'image': image,
      'read': read ? 1 : 0,
      'createdAt': createdAt,
    };
  }
}
