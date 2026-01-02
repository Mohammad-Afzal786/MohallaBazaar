// Path: lib/features/viewcart/presentation/bloc/viewcart_event.dart
import 'package:equatable/equatable.dart';

abstract class ViewCartEvent extends Equatable {
  const ViewCartEvent();

  @override
  List<Object?> get props => [];
}

class LoadViewCart extends ViewCartEvent {
  final String userId;
  final bool forceRefresh; // अगर true → remote से fetch करो

  const LoadViewCart({required this.userId, this.forceRefresh = false});

  @override
  List<Object?> get props => [userId, forceRefresh];
}
