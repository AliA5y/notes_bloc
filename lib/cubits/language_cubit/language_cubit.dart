import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit()
      : _language = 'ar',
        super(LanguageInitial());

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  late SharedPreferences prefs;
  String _language;

  bool get onBoarded {
    return prefs.getBool('onboarded') ?? false;
  }

  // bool get introduced {
  //   return prefs.getBool(PrefsKeys.tourKey) ?? false;
  // }

  String get language => _language;
  initLanguage() async {
    await _initPrefs();
    emit(LanguageChangeLoading());
    _language = prefs.getString(PrefsKeys.languageKey) ?? 'ar';
    emit(LanguageChangeSuccess());
  }

  void changeLanguage(String languageLabel) async {
    emit(LanguageChangeLoading());
    prefs.setString(PrefsKeys.languageKey, languageLabel);
    _language = languageLabel;
    emit(LanguageChangeSuccess());
  }

  void onBoard() async {
    prefs.setBool('onboarded', true);
  }

  // void setIntroduced() async {
  //   prefs.setBool(PrefsKeys.tourKey, true);
  // }
}
