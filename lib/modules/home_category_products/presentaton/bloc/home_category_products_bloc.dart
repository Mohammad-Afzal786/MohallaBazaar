import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_category_products_event.dart';
import 'home_category_products_state.dart';
import '../../domain/usecases/get_home_category_products_usecase.dart';

class HomeCategoryProductsBloc extends Bloc<HomeCategoryProductsEvent, HomeCategoryProductsState> {
  final GetHomeCategoryProductsUseCase useCase;

  HomeCategoryProductsBloc(this.useCase) : super(HomeCategoryProductsState.initial()) {
    on<HomeCategoryProductsRequested>(_onRequested);
  }

  Future<void> _onRequested(
      HomeCategoryProductsRequested event,
      Emitter<HomeCategoryProductsState> emit) async {

    // 1️⃣ Try to load cache
    try {
      final cached = await useCase.getCached();
      if (cached.isNotEmpty) {
        emit(state.copyWith(
          status: HomeCategoryProductsStatus.success,
          categories: cached,
        ));
      }
    } catch (_) {
      // Cache read error ignore
    }

    // 2️⃣ Fetch fresh data from API in background
    try {
      final fresh = await useCase.fetch();
      if (fresh.isNotEmpty) {
        emit(state.copyWith(
          status: HomeCategoryProductsStatus.success,
          categories: fresh,
        ));
      }
    } catch (_) {
      // Silent fail: do nothing, UI keeps cache or empty state
      // No error will ever be shown
    }
  }
}
