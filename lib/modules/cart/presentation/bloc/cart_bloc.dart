import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;

  CartBloc(this.addToCartUseCase) : super(CartInitial()) {
    on<AddCartItemEvent>(_onAddCartItem);
  }

  Future<void> _onAddCartItem(
      AddCartItemEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());

    try {
      // API call, ignore returned data
      await addToCartUseCase(event.cartItem);

      // Only success/failure matter
      emit(CartSuccess());
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }
}
