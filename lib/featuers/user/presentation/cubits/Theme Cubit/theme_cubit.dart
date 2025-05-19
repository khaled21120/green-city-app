import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_city/core/services/prefs_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.system));

  /// Load the saved theme from SharedPreferences
  Future<void> loadTheme() async {
    int themeIndex = PrefsService.loadTheme();
    ThemeMode mode = ThemeMode.system;

    if (themeIndex == 1) {
      mode = ThemeMode.light;
    } else if (themeIndex == 2) {
      mode = ThemeMode.dark;
    }
    emit(ThemeState(mode));
  }

  /// Toggle theme and save state
  Future<void> toggleTheme(ThemeMode mode) async {
    int themeIndex =
        mode == ThemeMode.light ? 1 : (mode == ThemeMode.dark ? 2 : 0);
    await PrefsService.saveTheme(themeIndex);
    emit(ThemeState(mode));
  }
}
