import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pulse/utils/local_storage.dart';
import 'package:pulse/utils/utils.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState());

  Future<void> setThemeMode() async {
    bool mode = state.darkMode;

    await prefs.setBool(LocalStorage.darkTheme, !mode);
    emit(state.copyWith(darkMode: !mode));
  }

  Future<void> setDarkMode() async {
    bool? mode = prefs.getBool(LocalStorage.darkTheme);
    emit(state.copyWith(darkMode: mode ?? false));
  }
}
