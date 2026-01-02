import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_cart_count_usecase.dart';
import 'cartcount_event.dart';
import 'cartcount_state.dart';
import '../../data/datasources/cart_item_local_data_source.dart';

class CartCountBloc extends Bloc<CartCountEvent, CartCountState> {
  final GetCartCountUseCase getCartCount;
  final CartLocalDataSource localDataSource;

  CartCountBloc(this.getCartCount, this.localDataSource)
      : super(CartCountInitial()) {
    on<LoadCartCount>((event, emit) async {
      try {
        // 1️⃣ Emit cached value immediately
        final cached = await localDataSource.getCachedCartCount();
        final initialCount = cached?.count ?? 0;
        emit(CartCountLoaded(initialCount));

        // 2️⃣ Fetch fresh value from remote API via usecase
        final remoteResult = await getCartCount(event.userId);

        // 3️⃣ Emit updated value if different
        if (remoteResult.count != initialCount) {
          emit(CartCountLoaded(remoteResult.count));
        }
      } catch (e) {
        // Emit cached value if available
        final cached = await localDataSource.getCachedCartCount();
        if (cached != null) {
          emit(CartCountLoaded(cached.count));
        } else {
          emit(CartCountError("Failed to load cart count"));
        }
      }
    });
  }
}
