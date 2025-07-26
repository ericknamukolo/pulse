part of 'overview_cubit.dart';

class OverviewState extends Equatable {
  final AppState appState;
  final Map<String, dynamic>? stats;
  final String? errorMessage;
  const OverviewState(
      {this.appState = AppState.initial, this.stats, this.errorMessage});

  @override
  List<Object?> get props => [appState, stats, errorMessage];

  OverviewState copyWith({
    AppState? appState,
    Map<String, dynamic>? stats,
    String? errorMessage,
  }) {
    return OverviewState(
      appState: appState ?? this.appState,
      stats: stats ?? this.stats,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
