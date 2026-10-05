part of 'website_cubit.dart';

sealed class WebsiteState extends Equatable {
  final List<Website> websites;
  final List<Team> teams;

  /// 'All', 'Personal', or a team name.
  final String selectedTeam;
  const WebsiteState(
      {this.websites = const [], this.teams = const [], this.selectedTeam = 'All'});

  @override
  List<Object> get props => [websites, teams, selectedTeam];
}

final class WebsiteInitial extends WebsiteState {}

final class WebsiteLoading extends WebsiteState {
  const WebsiteLoading(
      {super.websites, super.teams, super.selectedTeam});
}

final class WebsiteAdding extends WebsiteState {
  const WebsiteAdding(
      {super.websites, super.teams, super.selectedTeam});
}

final class WebsiteLoaded extends WebsiteState {
  const WebsiteLoaded(
      {super.websites, super.teams, super.selectedTeam});
}

final class WebsiteError extends WebsiteState {
  final String message;

  const WebsiteError(
      {required this.message, super.websites, super.teams, super.selectedTeam});

  @override
  List<Object> get props => [message];
}
