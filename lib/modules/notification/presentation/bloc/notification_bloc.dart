import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';
import '../../domain/usecases/get_notifications_usecase.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase useCase;

  NotificationBloc(this.useCase) : super(NotificationState.initial()) {
    on<NotificationRequested>(_onRequested);
  }

  Future<void> _onRequested(
    NotificationRequested event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      // 🔹 Load from local cache immediately (no loading state)
      final cached = await useCase.getCached();
      if (cached.isNotEmpty) {
        emit(state.copyWith(
          status: NotificationStatus.success,
          notifications: cached,
        ));
      }

      // 🔹 Fetch remote in background
      final fresh = await useCase.fetchFromApi(event.userId);

      // 🔹 Emit only if data changed
      if (fresh.isNotEmpty || fresh != cached) {
        emit(state.copyWith(
          status: NotificationStatus.success,
          notifications: fresh,
        ));
      }
    } catch (e) {
      // Optional: silently ignore error or show error toast/snackbar
    }
  }
}
