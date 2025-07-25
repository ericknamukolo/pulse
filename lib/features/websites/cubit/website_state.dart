part of 'website_cubit.dart';

sealed class WebsiteState extends Equatable {
  const WebsiteState();

  @override
  List<Object> get props => [];
}

final class WebsiteInitial extends WebsiteState {}

final class WebsiteLoading extends WebsiteState {}

final class WebsiteLoaded extends WebsiteState {
  final List<Website> websites;

  const WebsiteLoaded({this.websites = const []});

  @override
  List<Object> get props => [websites];
}

final class WebsiteError extends WebsiteState {
  final String message;

  const WebsiteError({required this.message});

  @override
  List<Object> get props => [message];
}
