part of 'overview_cubit.dart';

class OverviewState extends Equatable {
  final AppState appState;
  final Map<String, dynamic>? stats;
  final String? errorMessage;
  final String metric;
  const OverviewState(
      {this.appState = AppState.initial,
      this.metric = 'Url',
      this.stats,
      this.errorMessage});

  @override
  List<Object?> get props => [appState, stats, errorMessage, metric];

  OverviewState copyWith({
    AppState? appState,
    Map<String, dynamic>? stats,
    String? errorMessage,
    String? metric,
  }) {
    return OverviewState(
      appState: appState ?? this.appState,
      stats: stats ?? this.stats,
      errorMessage: errorMessage ?? this.errorMessage,
      metric: metric ?? this.metric,
    );
  }
}
