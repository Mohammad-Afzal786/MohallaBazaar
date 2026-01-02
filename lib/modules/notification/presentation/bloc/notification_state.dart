import 'package:equatable/equatable.dart';
import '../../domain/entities/notification_entity.dart';

enum NotificationStatus { initial, loading, success, failure }

class NotificationState extends Equatable {
  final NotificationStatus status;
  final List<NotificationEntity> notifications;
  final String? error;

  const NotificationState({
    required this.status,
    required this.notifications,
    this.error,
  });

  factory NotificationState.initial() => NotificationState(
        status: NotificationStatus.initial,
        notifications: [],
      );

  NotificationState copyWith({
    NotificationStatus? status,
    List<NotificationEntity>? notifications,
    String? error,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, notifications, error];
}
