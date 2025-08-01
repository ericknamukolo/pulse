import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse/features/events/models/event.dart';
import 'package:pulse/features/sessions/model/session.dart';
import 'package:pulse/features/sessions/repo/sessions_repo.dart';

import '../../../utils/utils.dart';

part 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  SessionsCubit() : super(SessionsState());

  Future<void> getSessions({
    required String id,
    DateTime? start,
    DateTime? end,
    int? pageNumber,
  }) async {
    bool isRefresh = pageNumber == null;
    emit(state.copyWith(
        appState: isRefresh ? AppState.loading : AppState.secondaryLoading,
        sessions: isRefresh ? [] : null));
    try {
      var res = await SessionsRepo()
          .getSessions(id: id, start: start, end: end, pageNumber: pageNumber);

      List<Session> sessions = [...state.sessions];
      sessions.addAll(res);
      emit(state.copyWith(
          appState: isRefresh ? AppState.complete : AppState.secondaryComplete,
          sessions: sessions));
    } catch (e) {
      emit(
          state.copyWith(appState: AppState.error, errorMessage: e.toString()));
    }
  }

  Future<void> getSessionEvents({
    required String websiteId,
    required String id,
    DateTime? start,
    DateTime? end,
  }) async {
    emit(state.copyWith(appState: AppState.loading, events: []));
    try {
      var res = await SessionsRepo().getSessionEvents(
          id: id, start: start, end: end, websiteId: websiteId);
      emit(state.copyWith(appState: AppState.complete, events: res));
    } catch (e) {
      emit(
          state.copyWith(appState: AppState.error, errorMessage: e.toString()));
    }
  }
}
