// Path: lib/features/categories/presentation/bloc/categorydetails_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'categorydetails_event.dart';
import 'categorydetails_state.dart';
import '../../domain/usecases/get_categorydetails_usecase.dart';

class CategoryDetailsBloc extends Bloc<CategoryDetailsEvent, CategoryDetailsState> {
  final GetCategoryDetailsUseCase useCase;

  CategoryDetailsBloc(this.useCase) : super(CategoryDetailsState.initial()) {
    on<CategoryDetailsRequested>(_onRequested);
  }

  Future<void> _onRequested(CategoryDetailsRequested event, Emitter<CategoryDetailsState> emit) async {
    emit(state.copyWith(status: CategoryDetailsStatus.loading));
    try {
      // 1) Try cached
      final cached = await useCase.getCached(event.categoryId);
      if (cached != null) {
        emit(state.copyWith(status: CategoryDetailsStatus.success, details: cached));
      }

      // 2) Fetch fresh from API
      try {
        final fresh = await useCase.fetchFresh(event.categoryId);
        emit(state.copyWith(status: CategoryDetailsStatus.success, details: fresh));
      } catch (e) {
        // if nothing emitted yet (cache was null), show failure
        if (cached == null) {
          emit(state.copyWith(status: CategoryDetailsStatus.failure, error: e.toString()));
        } else {
          // keep cached UI and just log error
          // Optionally you can emit a 'stale' state
        }
      }
    } catch (e) {
      emit(state.copyWith(status: CategoryDetailsStatus.failure, error: e.toString()));
    }
  }
}
