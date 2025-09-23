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

    // 1️⃣ Pehle cache load karo
    try {
      final cached = await useCase.getCachedProducts(categoryId);
      if (cached.isNotEmpty) {
        emit(state.copyWith(
          status: CategoryDetailsStatus.success,
          products: cached,
        ));
      }
    } catch (_) {
      // Cache read me error ignore
    }

    // 2️⃣ Remote fetch asynchronously (loading only if no cache)
    try {
      if (state.products.isEmpty) {
        emit(state.copyWith(status: CategoryDetailsStatus.loading));
      }

      final fresh = await useCase.fetchProducts(categoryId);

      if (fresh.isNotEmpty) {
        emit(state.copyWith(
          status: CategoryDetailsStatus.success,
          products: fresh,
        ));
      } else if (state.products.isEmpty) {
        // Agar remote bhi empty, aur cache empty
        emit(state.copyWith(
          status: CategoryDetailsStatus.failure,
          error: "No products available",
        ));
      }
    } catch (e) {
      // Network failure → sirf error emit karo, agar cache already hai to loading nahi
      if (state.products.isEmpty) {
        emit(state.copyWith(
          status: CategoryDetailsStatus.failure,
          error: "Network error: ${e.toString()}",
        ));
      }
    }
  }
}
