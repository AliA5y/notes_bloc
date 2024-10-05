import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<Brightness> {
  ThemeCubit() : super(Brightness.light) {
    _getThemeFromPrefs();
  }

  Future<void> _saveThemeToPrefs({required Brightness brightness}) async {
    final themeIndex = brightness == Brightness.light ? 0 : 1;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setInt(PrefsKeys.themeKey, themeIndex);
  }

  Future<void> _getThemeFromPrefs() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final savedThemeIndex = sharedPreferences.getInt(PrefsKeys.themeKey) ?? 0;
    final savedTheme =
        savedThemeIndex == 0 ? Brightness.light : Brightness.dark;
    emit(savedTheme);
  }

  void toggleTheme() {
    emit(state == Brightness.light ? Brightness.dark : Brightness.light);
    _saveThemeToPrefs(brightness: state);
  }
}
