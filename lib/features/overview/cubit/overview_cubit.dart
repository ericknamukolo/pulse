import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse/features/overview/repo/overview_repo.dart';
import 'package:pulse/utils/utils.dart';

part 'overview_state.dart';

class OverviewCubit extends Cubit<OverviewState> {
  OverviewCubit() : super(OverviewState());

  Future<void> getStats(
      {required String id, DateTime? start, DateTime? end}) async {
    emit(state.copyWith(appState: AppState.loading));
    try {
      var stats =
          await OverviewRepo().getSummaryStats(id: id, start: start, end: end);
      emit(state.copyWith(stats: stats, appState: AppState.complete));
    } catch (e) {
      emit(
          state.copyWith(errorMessage: e.toString(), appState: AppState.error));
    }
  }
}
