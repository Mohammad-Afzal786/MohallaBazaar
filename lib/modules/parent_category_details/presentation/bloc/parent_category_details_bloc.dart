// Path: lib/features/categories/presentation/bloc/parent_categorydetails_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/usecases/parent_categorydetails_usecase.dart';
import 'parent_categorydetails_event.dart';
import 'parent_categorydetails_state.dart';

class ParentCategoryDetailsBloc
    extends Bloc<ParentCategoryDetailsEvent, ParentCategoryDetailsState> {
  final ParentCategoryDetailsUseCase useCase;

  ParentCategoryDetailsBloc(this.useCase)
      : super(ParentCategoryDetailsState.initial()) {
    on<ParentCategoryDetailsRequested>(_onRequested);
  }

  Future<void> _onRequested(
    ParentCategoryDetailsRequested event,
    Emitter<ParentCategoryDetailsState> emit,
  ) async {
    final parentCategoryId = event.parentCategoryId;

    // 🔹 Step 0: Clear old data to prevent flicker
    emit(ParentCategoryDetailsState.initial().copyWith(
      status: ParentCategoryDetailsStatus.loading,
      details: null,
      error: null,
    ));

    // 🔹 Step 1: Try to load cache
    final cached = await _safeGetCached(parentCategoryId);
    if (cached != null) {
      emit(state.copyWith(
        status: ParentCategoryDetailsStatus.success,
        details: cached,
      ));
    }

    // 🔹 Step 2: Fetch fresh data from API in background
    try {
      final fresh = await useCase.fetchFresh(parentCategoryId);
      emit(state.copyWith(
        status: ParentCategoryDetailsStatus.success,
        details: fresh,
      ));
    } catch (e) {
      // Show error only if no cached data exists
      if (cached == null) {
        emit(state.copyWith(
          status: ParentCategoryDetailsStatus.failure,
          error: _mapErrorToMessage(e),
        ));
      }
    }
  }

  /// 🔹 Safe wrapper for cache fetching
  Future<dynamic> _safeGetCached(String categoryId) async {
    try {
      return await useCase.getCached(categoryId);
    } catch (_) {
      return null;
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
