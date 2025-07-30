part of 'overview_cubit.dart';

class OverviewState extends Equatable {
  final AppState appState;
  final Map<String, dynamic>? stats;
  final String? errorMessage;
  final String metric;
  final String unit;
  final List<Metric> metrics;
  const OverviewState(
      {this.appState = AppState.initial,
      this.metric = 'Url',
      this.unit = 'Day',
      this.stats,
      this.errorMessage,
      this.metrics = const []});

  @override
  List<Object?> get props => [appState, stats, errorMessage, metric, metrics];

  OverviewState copyWith({
    AppState? appState,
    Map<String, dynamic>? stats,
    String? errorMessage,
    String? metric,
    String? unit,
    List<Metric>? metrics,
  }) {
    return OverviewState(
      appState: appState ?? this.appState,
      stats: stats ?? this.stats,
      errorMessage: errorMessage ?? this.errorMessage,
      metric: metric ?? this.metric,
      metrics: metrics ?? this.metrics,
      unit: unit ?? this.unit,
    );
  }
}
