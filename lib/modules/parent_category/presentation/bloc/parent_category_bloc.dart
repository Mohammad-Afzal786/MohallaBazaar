import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/parent_category_entity.dart';
import '../../domain/usecases/parent_category_usecase.dart';

/// ------------------------------------------------------------
/// EVENTS
/// ------------------------------------------------------------
abstract class ParentCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ParentCategoryRequested extends ParentCategoryEvent {}

/// ------------------------------------------------------------
/// STATES
/// ------------------------------------------------------------
enum ParentCategoryStatus { initial, loading, success, empty, failure }

class ParentCategoryState extends Equatable {
  final ParentCategoryStatus status;
  final List<ParentCategoryhomeEntity> categories;
  final String? error;

  const ParentCategoryState({
    required this.status,
    required this.categories,
    this.error,
  });

  factory ParentCategoryState.initial() => const ParentCategoryState(
        status: ParentCategoryStatus.initial,
        categories: [],
      );

  ParentCategoryState copyWith({
    ParentCategoryStatus? status,
    List<ParentCategoryhomeEntity>? categories,
    String? error,
  }) {
    return ParentCategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, categories, error];
}

/// ------------------------------------------------------------
/// BLOC
/// ------------------------------------------------------------
class ParentCategoryBloc extends Bloc<ParentCategoryEvent, ParentCategoryState> {
  final ParentCategoryUseCase useCase;

  ParentCategoryBloc(this.useCase) : super(ParentCategoryState.initial()) {
    on<ParentCategoryRequested>(_onRequested);
  }

  Future<void> _onRequested(
      ParentCategoryRequested event, Emitter<ParentCategoryState> emit) async {
    List<ParentCategoryhomeEntity> cachedList = [];

    // Step 1: Try loading cache
    try {
      final cached = await useCase.getCachedCategories();
      if (cached.isNotEmpty) {
        cachedList = cached;
        emit(state.copyWith(
          status: ParentCategoryStatus.success,
          categories: cached,
        ));
      }
    } catch (_) {
      // Cache read failed → ignore
    }

    // Step 2: Fetch fresh data from API in background
    try {
      final fresh = await useCase.fetchAndCacheCategories();

      // Only update UI if fresh data differs
      if (_isDifferent(fresh, cachedList)) {
        emit(state.copyWith(
          status: ParentCategoryStatus.success,
          categories: fresh,
        ));
      }
    } catch (_) {
      // API failed
      if (cachedList.isEmpty) {
        emit(state.copyWith(
          status: ParentCategoryStatus.failure,
          categories: [],
          error: "Failed to fetch categories",
        ));
      }
      // Else: cache exists → silently keep it
    }
  }

  // Compare cached and fresh lists to prevent unnecessary UI updates
  bool _isDifferent(
      List<ParentCategoryhomeEntity> fresh, List<ParentCategoryhomeEntity> cached) {
    if (fresh.length != cached.length) return true;
    for (int i = 0; i < fresh.length; i++) {
      if (fresh[i].parentCategoryId != cached[i].parentCategoryId) return true;
    }
    return false;
  }
}
