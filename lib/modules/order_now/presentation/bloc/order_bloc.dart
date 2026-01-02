import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import 'package:mohalla_bazaar/modules/order_now/domain/repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc(this.repository) : super(OrderInitial()) {
    on<OrderNowSubmitted>((event, emit) async {
      if (event.userId.isEmpty) {
        emit(const OrderFailure('User ID is missing!'));
        return;
      }

      emit(OrderLoading());

      final result = await repository.placeOrder(event.userId,event.useraddress);

      result.fold(
        (failure) {
          final message = (failure is ServerFailure && failure.message.isNotEmpty)
              ? failure.message
              : "Unknown error";
          emit(OrderFailure(message));
        },
        (order) => emit(OrderSuccess(order)),
      );
    });
  }
}
