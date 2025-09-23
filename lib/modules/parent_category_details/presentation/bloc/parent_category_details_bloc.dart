// Path: lib/features/categories/presentation/bloc/parent_categorydetails_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/usecases/parent_categorydetails_usecase.dart';
import 'parent_categorydetails_event.dart';
import 'parent_categorydetails_state.dart';

class ParentCategoryDetailsBloc extends Bloc<ParentCategoryDetailsEvent, ParentCategoryDetailsState> {
  final ParentCategoryDetailsUseCase useCase;

  ParentCategoryDetailsBloc(this.useCase) : super(ParentCategoryDetailsState.initial()) {
    on<ParentCategoryDetailsRequested>(_onRequested);
  }

  Future<void> _onRequested(ParentCategoryDetailsRequested event, Emitter<ParentCategoryDetailsState> emit) async {
    emit(state.copyWith(status: ParentCategoryDetailsStatus.loading));
    try {
      // 1) Try cached
      final cached = await useCase.getCached(event.parentCategoryId);
      if (cached != null) {
        emit(state.copyWith(status: ParentCategoryDetailsStatus.success, details: cached));
      }

      // 2) Fetch fresh from API
      try {
        final fresh = await useCase.fetchFresh(event.parentCategoryId);
        emit(state.copyWith(status: ParentCategoryDetailsStatus.success, details: fresh));
      } catch (e) {
        // if nothing emitted yet (cache was null), show failure
        if (cached == null) {
          emit(state.copyWith(status: ParentCategoryDetailsStatus.failure, error: e.toString()));
        } else {
          // keep cached UI and just log error
          // Optionally you can emit a 'stale' state
        }
      }
    } catch (e) {
      emit(state.copyWith(status: ParentCategoryDetailsStatus.failure, error: e.toString()));
    }
  }
}
