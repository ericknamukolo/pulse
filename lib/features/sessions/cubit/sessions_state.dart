part of 'sessions_cubit.dart';

class SessionsState extends Equatable {
  final AppState appState;

  final String? errorMessage;
  const SessionsState({
    this.appState = AppState.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [appState, errorMessage];

  SessionsState copyWith({
    AppState? appState,
    String? errorMessage,
  }) {
    return SessionsState(
      appState: appState ?? this.appState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
