part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final bool darkMode;
  const ThemeState({this.darkMode = true});

  @override
  List<Object> get props => [darkMode];

  ThemeState copyWith({bool? darkMode}) {
    return ThemeState(darkMode: darkMode ?? this.darkMode);
  }
}
