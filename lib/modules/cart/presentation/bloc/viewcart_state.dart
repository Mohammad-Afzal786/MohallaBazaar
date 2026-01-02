// Path: lib/features/viewcart/presentation/bloc/viewcart_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/viewcart_entity.dart';

enum ViewCartStatus { initial, loading, success, failure }

class ViewCartState extends Equatable {
  final ViewCartStatus status;
  final ViewCartEntity? cart;
  final String? error;

  const ViewCartState({required this.status, this.cart, this.error});

  factory ViewCartState.initial() => const ViewCartState(status: ViewCartStatus.initial);

  ViewCartState copyWith({
    ViewCartStatus? status,
    ViewCartEntity? cart,
    String? error,
  }) {
    return ViewCartState(
      status: status ?? this.status,
      cart: cart ?? this.cart,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, cart, error];
}
