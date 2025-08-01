part of 'sessions_cubit.dart';

class SessionsState extends Equatable {
  final AppState appState;
  final List<Session> sessions;
  final List<Event> events;
  final String? errorMessage;
  const SessionsState({
    this.appState = AppState.initial,
    this.errorMessage,
    this.sessions = const [],
    this.events = const [],
  });

  @override
  List<Object?> get props => [appState, errorMessage, sessions, events];

  SessionsState copyWith({
    AppState? appState,
    String? errorMessage,
    List<Session>? sessions,
    List<Event>? events,
  }) {
    return SessionsState(
      appState: appState ?? this.appState,
      errorMessage: errorMessage ?? this.errorMessage,
      sessions: sessions ?? this.sessions,
      events: events ?? this.events,
    );
  }
}
