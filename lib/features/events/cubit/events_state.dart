part of 'events_cubit.dart';

class EventsState extends Equatable {
  final AppState appState;

  final String? errorMessage;
  const EventsState({
    this.appState = AppState.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [appState, errorMessage];

  EventsState copyWith({
    AppState? appState,
    String? errorMessage,
  }) {
    return EventsState(
      appState: appState ?? this.appState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
