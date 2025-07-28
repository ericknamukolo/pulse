import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse/features/events/models/event.dart';
import 'package:pulse/features/events/repo/events_repo.dart';
import 'package:pulse/utils/utils.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  EventsCubit() : super(EventsState());

  Future<void> getEvents(
      {required String id, DateTime? start, DateTime? end}) async {
    emit(state.copyWith(appState: AppState.loading));
    try {
      var res = await EventsRepo().getEvents(id: id);
      emit(state.copyWith(appState: AppState.complete, events: res));
    } catch (e) {
      emit(
          state.copyWith(appState: AppState.error, errorMessage: e.toString()));
    }
  }
}
