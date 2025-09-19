import 'package:flutter_bloc/flutter_bloc.dart';
import 'categories_event.dart';
import 'categories_state.dart';
import '../../domain/usecases/get_categories_usecase.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase useCase;

  CategoriesBloc(this.useCase) : super(CategoriesState.initial()) {
    on<CategoriesRequested>(_onRequested);
  }

Future<void> _onRequested(
  CategoriesRequested event,
  Emitter<CategoriesState> emit,
) async {
  try {
    // 1️⃣ Pehle cache load karo
    final cached = await useCase.getCachedCategories();
    if (cached.isNotEmpty) {
      emit(state.copyWith(status: CategoriesStatus.success, categories: cached));
    }

    // 2️⃣ Phir API fetch karo asynchronously aur check karo emit.isDone
    try {
      final fresh = await useCase.fetchCategories();
      if (!emit.isDone) {
        emit(state.copyWith(status: CategoriesStatus.success, categories: fresh));
      }
    } catch (e) {
      // API fail → optional ignore ya log
      print("API fetch failed: $e");
    }
  } catch (e) {
    // Agar cache hi empty ho aur exception → failure emit karo
    if (!emit.isDone) {
      emit(state.copyWith(status: CategoriesStatus.failure, error: e.toString()));
    }
  }
}

}

