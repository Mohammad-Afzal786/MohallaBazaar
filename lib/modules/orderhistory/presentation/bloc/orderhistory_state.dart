import 'package:equatable/equatable.dart';
import '../../domain/entities/orderhistory_entity.dart';

enum OrderHistoryStatus { initial, loading, success, failure }

class OrderHistoryState extends Equatable {
  final OrderHistoryStatus status;
  final OrderHistoryEntity? orderHistory;
  final String? error;

  const OrderHistoryState({
    required this.status,
    this.orderHistory,
    this.error,
  });

  factory OrderHistoryState.initial() =>
      const OrderHistoryState(status: OrderHistoryStatus.initial);

  OrderHistoryState copyWith({
    OrderHistoryStatus? status,
    OrderHistoryEntity? orderHistory,
    String? error,
  }) {
    return OrderHistoryState(
      status: status ?? this.status,
      orderHistory: orderHistory ?? this.orderHistory,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, orderHistory, error];
}
