class NotificationEntity {
  final String id;
  final String title;
  final String message;
  final String image;
  final bool read;
  final String createdAt;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.image,
    required this.read,
    required this.createdAt,
  });
}
