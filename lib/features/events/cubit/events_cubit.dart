import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse/features/events/repo/events_repo.dart';
import 'package:pulse/utils/utils.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(EventsState());

  Future<void> getEvents(
      {required String id, DateTime? start, DateTime? end}) async {
    try {
      await EventsRepo().getEvents(id: id);
    } catch (e) {
      emit(
          state.copyWith(appState: AppState.error, errorMessage: e.toString()));
    }
  }
}
