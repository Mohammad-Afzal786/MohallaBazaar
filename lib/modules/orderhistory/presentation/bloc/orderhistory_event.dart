import 'package:equatable/equatable.dart';

abstract class OrderHistoryEvent extends Equatable {
  const OrderHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrderHistory extends OrderHistoryEvent {
  final String userId;
  const LoadOrderHistory(this.userId);

  @override
  List<Object?> get props => [userId];
}

class RefreshOrderHistory extends OrderHistoryEvent {
  final String userId;
  const RefreshOrderHistory(this.userId);

  @override
  List<Object?> get props => [userId];
}
