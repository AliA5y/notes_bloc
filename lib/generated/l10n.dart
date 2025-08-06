// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `My Notes`
  String get myNotes {
    return Intl.message('My Notes', name: 'myNotes', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `dark`
  String get dark {
    return Intl.message('dark', name: 'dark', desc: '', args: []);
  }

  /// `light`
  String get light {
    return Intl.message('light', name: 'light', desc: '', args: []);
  }

  /// `Language`
  String get lang {
    return Intl.message('Language', name: 'lang', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Failed to load notes`
  String get loadError {
    return Intl.message(
      'Failed to load notes',
      name: 'loadError',
      desc: '',
      args: [],
    );
  }

  /// `Quick Settings`
  String get quickSett {
    return Intl.message(
      'Quick Settings',
      name: 'quickSett',
      desc: '',
      args: [],
    );
  }

  /// `No Notes Found`
  String get emptyNotes {
    return Intl.message(
      'No Notes Found',
      name: 'emptyNotes',
      desc: '',
      args: [],
    );
  }

  /// `Add a Note`
  String get addNote {
    return Intl.message('Add a Note', name: 'addNote', desc: '', args: []);
  }

  /// `Edit a Note`
  String get EditNote {
    return Intl.message('Edit a Note', name: 'EditNote', desc: '', args: []);
  }

  /// `Enter Note Title`
  String get noteTitle {
    return Intl.message(
      'Enter Note Title',
      name: 'noteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter Note Text`
  String get noteText {
    return Intl.message(
      'Enter Note Text',
      name: 'noteText',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message('User Name', name: 'userName', desc: '', args: []);
  }

  /// `User Profile`
  String get editProfile {
    return Intl.message(
      'User Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Enter You User Name`
  String get nameFieldHint {
    return Intl.message(
      'Enter You User Name',
      name: 'nameFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Choose Avatar`
  String get chooseAvatar {
    return Intl.message(
      'Choose Avatar',
      name: 'chooseAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Developed By`
  String get developed {
    return Intl.message('Developed By', name: 'developed', desc: '', args: []);
  }

  /// `Ali Alzaidy`
  String get myname {
    return Intl.message('Ali Alzaidy', name: 'myname', desc: '', args: []);
  }

  /// `Great!`
  String get obT5 {
    return Intl.message('Great!', name: 'obT5', desc: '', args: []);
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Do you really want to delete this note?`
  String get deleteNoteMsg {
    return Intl.message(
      'Do you really want to delete this note?',
      name: 'deleteNoteMsg',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete all the selected notes?`
  String get deleteMultiNotesMsg {
    return Intl.message(
      'Do you really want to delete all the selected notes?',
      name: 'deleteMultiNotesMsg',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to close the app?`
  String get appCloseMsg {
    return Intl.message(
      'Do you really want to close the app?',
      name: 'appCloseMsg',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `choose a language`
  String get language {
    return Intl.message(
      'choose a language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Old Version !\nNew features are available. Please, update to latest version to enjoy a new experience`
  String get versionerro {
    return Intl.message(
      'Old Version !\nNew features are available. Please, update to latest version to enjoy a new experience',
      name: 'versionerro',
      desc: '',
      args: [],
    );
  }

  /// `Network error, ensure you have a stable connection or read a story from history untill connection is back`
  String get neterror {
    return Intl.message(
      'Network error, ensure you have a stable connection or read a story from history untill connection is back',
      name: 'neterror',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
