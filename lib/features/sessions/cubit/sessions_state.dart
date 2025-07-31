part of 'sessions_cubit.dart';

class SessionsState extends Equatable {
  final AppState appState;
  final List<Session> sessions;
  final String? errorMessage;
  const SessionsState({
    this.appState = AppState.initial,
    this.errorMessage,
    this.sessions = const [],
  });

  @override
  List<Object?> get props => [appState, errorMessage, sessions];

  SessionsState copyWith({
    AppState? appState,
    String? errorMessage,
    List<Session>? sessions,
  }) {
    return SessionsState(
      appState: appState ?? this.appState,
      errorMessage: errorMessage ?? this.errorMessage,
      sessions: sessions ?? this.sessions,
    );
  }
}
