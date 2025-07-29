import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse/features/sessions/repo/sessions_repo.dart';

import '../../../utils/utils.dart';

part 'sessions_state.dart';

class SessionsCubit extends Cubit<SessionsState> {
  SessionsCubit() : super(SessionsState());

  Future<void> getSessions(
      {required String id, DateTime? start, DateTime? end}) async {
    try {
      await SessionsRepo().getSessions(id: id);
    } catch (e) {
      emit(
          state.copyWith(appState: AppState.error, errorMessage: e.toString()));
    }
  }
}
