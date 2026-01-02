import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohalla_bazaar/modules/orderhistory/domain/entities/orderhistory_entity.dart';
import 'orderhistory_event.dart';
import 'orderhistory_state.dart';
import '../../domain/usecases/orderhistory_usecase.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final GetOrderHistoryUseCase useCase;

  OrderHistoryBloc(this.useCase) : super(OrderHistoryState.initial()) {
    on<LoadOrderHistory>(_onLoad);
  }
Future<void> _onLoad(
  LoadOrderHistory event,
  Emitter<OrderHistoryState> emit,
) async {
  OrderHistoryEntity? cached;
  try {
    // STEP 1: Local (cached) data check
    cached = await useCase.getCachedOrderHistory(event.userId);

    if (cached != null && cached.orders.isNotEmpty) {
      // Cache hai → turant show karo
      emit(state.copyWith(
        status: OrderHistoryStatus.success,
        orderHistory: cached,
      ));
    } else {
      // Cache empty → show failure immediately
      emit(state.copyWith(
        status: OrderHistoryStatus.failure,
        error: "No orders found",
      ));
    }

    // STEP 2: Remote fetch (background)
    final fresh = await useCase.getRemoteOrderHistory(event.userId);

    // Agar remote data status error ya empty → ignore, UI me already failure hai
    if (fresh.status.toLowerCase() == "error" || fresh.orders.isEmpty) {
      return;
    }

    // Remote data success → UI update karo
    emit(state.copyWith(
      status: OrderHistoryStatus.success,
      orderHistory: fresh,
    ));
  } catch (e) {
    // Remote fail → agar cache tha, wo already dikha raha hai, silent fail
    if (cached == null || cached.orders.isEmpty) {
      emit(state.copyWith(
        status: OrderHistoryStatus.failure,
        error: "No orders found",
      ));
    }
  }
}


}

