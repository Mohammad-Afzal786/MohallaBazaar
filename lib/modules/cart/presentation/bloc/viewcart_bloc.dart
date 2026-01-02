import 'package:flutter_bloc/flutter_bloc.dart';
import 'viewcart_event.dart';
import 'viewcart_state.dart';
import '../../domain/usecases/viewcart_usecase.dart';

class ViewCartBloc extends Bloc<ViewCartEvent, ViewCartState> {
  final ViewCartUseCase useCase;

  ViewCartBloc(this.useCase) : super(ViewCartState.initial()) {
    on<LoadViewCart>(_onLoad);
  }

  Future<void> _onLoad(LoadViewCart event, Emitter<ViewCartState> emit) async {
    final userId = event.userId;

    // 1️⃣ Try fetch cache first → fast UI
    try {
      final cached = await useCase.getCachedViewCart(userId);
      if (cached != null) {
        emit(state.copyWith(status: ViewCartStatus.success, cart: cached));
      }
    } catch (_) {
      // ignore cache read errors
    }

    // 2️⃣ Always fetch remote → background update
    try {
      final fresh = await useCase.fetchViewCart(userId); 
      // fetchViewCart internally updates cache
      emit(state.copyWith(status: ViewCartStatus.success, cart: fresh));
        } catch (e) {
      // Agar cache pehle se dikha diya → ignore error
      if (state.cart == null) {
        emit(state.copyWith(
          status: ViewCartStatus.failure,
          error: "Network error: ${e.toString()}",
        ));
      }
    }
  }
}
