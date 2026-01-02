import 'package:flutter_bloc/flutter_bloc.dart';
import 'banner_event.dart';
import 'banner_state.dart';
import '../../domain/usecases/get_banners_usecase.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBannersUseCase useCase;

  BannerBloc(this.useCase) : super(BannerState.initial()) {
    on<BannerRequested>(_onRequested);
  }

  Future<void> _onRequested(BannerRequested event, Emitter<BannerState> emit) async {
    try {
      emit(state.copyWith(status: BannerStatus.loading));

      final cached = await useCase.getCached();
      if (cached.isNotEmpty) {
        emit(state.copyWith(status: BannerStatus.success, banners: cached));
      }

      final fresh = await useCase.fetch();
      emit(state.copyWith(status: BannerStatus.success, banners: fresh));
    } catch (e) {
      emit(state.copyWith(status: BannerStatus.failure, error: e.toString()));
    }
  }
}
