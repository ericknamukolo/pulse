part of 'website_cubit.dart';

sealed class WebsiteState extends Equatable {
  final List<Website> websites;
  const WebsiteState({this.websites = const []});

  @override
  List<Object> get props => [websites];
}

final class WebsiteInitial extends WebsiteState {}

final class WebsiteLoading extends WebsiteState {
  const WebsiteLoading({super.websites});
}

final class WebsiteLoaded extends WebsiteState {
  const WebsiteLoaded({super.websites});
}

final class WebsiteError extends WebsiteState {
  final String message;

  const WebsiteError({required this.message});

  @override
  List<Object> get props => [message];
}
