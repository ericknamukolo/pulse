part of 'events_cubit.dart';

class EventsState extends Equatable {
  final AppState appState;
  final List<Event> events;
  final String? errorMessage;

  const EventsState({
    this.appState = AppState.initial,
    this.errorMessage,
    this.events = const [],
  });

  @override
  List<Object?> get props => [appState, errorMessage, events];

  EventsState copyWith({
    AppState? appState,
    String? errorMessage,
    List<Event>? events,
  }) {
    return EventsState(
      appState: appState ?? this.appState,
      errorMessage: errorMessage ?? this.errorMessage,
      events: events ?? this.events,
    );
  }
}
