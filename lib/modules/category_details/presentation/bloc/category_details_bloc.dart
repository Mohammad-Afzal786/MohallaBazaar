import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_details_event.dart';
import 'category_details_state.dart';
import '../../domain/usecases/category_details_usecase.dart';

class CategoryDetailsBloc
    extends Bloc<CategoryDetailsEvent, CategoryDetailsState> {
  final CategoryDetailsUseCase useCase;

  CategoryDetailsBloc(this.useCase) : super(CategoryDetailsState.initial()) {
    on<CategoryProductsRequested>(_onCategoryProductsRequested);
  }

  Future<void> _onCategoryProductsRequested(
    CategoryProductsRequested event,
    Emitter<CategoryDetailsState> emit,
  ) async {
    final categoryId = event.categoryId;
    bool hasCache = false;

    // 🧹 Step 0: Purana data clear karo (avoid flicker of old products)
    emit(CategoryDetailsState.initial().copyWith(
      status: CategoryDetailsStatus.loading,
      products: [],
      error: null,
    ));

    // 1️⃣ Cache load karo (SQLite already filters by category_id)
    try {
      final cached = await useCase.getCachedProducts(categoryId);

      if (cached.isNotEmpty) {
        hasCache = true;
        emit(state.copyWith(
          status: CategoryDetailsStatus.success,
          products: cached,
          error: null,
        ));
      }
    } catch (_) {
      // Cache read me error ignore karo
    }

    // 2️⃣ Background me fresh data fetch karo
    try {
      final fresh = await useCase.fetchProducts(categoryId);

      if (fresh.isNotEmpty) {
        emit(state.copyWith(
          status: CategoryDetailsStatus.success,
          products: fresh,
          error: null,
        ));
      } else if (!hasCache) {
        emit(state.copyWith(
          status: CategoryDetailsStatus.failure,
          error: "No products available",
        ));
      }
    } catch (e) {
      if (!hasCache) {
        emit(state.copyWith(
          status: CategoryDetailsStatus.failure,
          error: _mapErrorToMessage(e),
        ));
      }
    }
  }
   /// 🔹 Map technical errors to user-friendly messages
  String _mapErrorToMessage(dynamic error) {
    final msg = error.toString().toLowerCase();
    if (msg.contains("socket") || msg.contains("failed host lookup")) {
      return "No internet connection. Please check your network.";
    } else if (msg.contains("timeout")) {
      return "Connection timed out. Please try again.";
    } else if (msg.contains("500") || msg.contains("502") || msg.contains("503")) {
      return "Server is temporarily unavailable. Please try again later.";
    } else {
      return "Something went wrong. Please try again.";
    }
  }
}
