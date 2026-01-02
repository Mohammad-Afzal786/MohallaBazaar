import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class NotificationRequested extends NotificationEvent {
  final String userId;

  const NotificationRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}
