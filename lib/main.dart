import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/cubits/language_cubit/language_cubit.dart';
import 'package:notes_bloc/cubits/theme_cubit/theme_cubit.dart';
import 'package:notes_bloc/data/repositories/home_repository.dart';
import 'package:notes_bloc/simple_bloc_observer.dart';
import 'package:notes_bloc/views/edit_profile_view.dart';
import 'package:notes_bloc/views/home_view.dart';
import 'package:notes_bloc/views/language_setting_view.dart';
import 'package:notes_bloc/views/splash_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'blocs/home/home_bloc.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
    // this step, it will use the sqlite version available on the system.
    databaseFactory = databaseFactoryFfi;
  }
  Bloc.observer = SimpleBlocObserver();

  final lanCubit = LanguageCubit();
  await lanCubit.initLanguage();

  runApp(MyApp(lanCubit: lanCubit));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.lanCubit});
  final LanguageCubit lanCubit;

  @override
  Widget build(BuildContext context) {
    NoteRepository repo = NoteRepository.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => lanCubit),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return BlocBuilder<ThemeCubit, Brightness>(
            builder: (context, brightnessState) {
              return MaterialApp(
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: Locale(context.read<LanguageCubit>().language),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    brightness: brightnessState,
                    seedColor: const Color(0xFF20B4F0),
                  ),
                ),
                builder: (context, child) {
                  return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaler: MediaQuery.textScalerOf(context)
                            .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.2),
                      ),
                      child: child!);
                },
                home: const SplashScreen(),
                routes: {
                  EditProfileView.id: (context) => const EditProfileView(),
                  LanguageSettingView.id: (context) =>
                      const LanguageSettingView(),
                  HomeView.id: (context) => BlocProvider(
                        create: (context) => NoteBloc(repo),
                        child: const HomeView(),
                      )
                },
              );
            },
          );
        },
      ),
    );
  }
}

/*

- lib
  - blocs
    - home
      - home_bloc.dart
      - home_event.dart
      - home_state.dart
  - controllers
    - note_controller.dart
  - data
    - models
      - note_model.dart
    - repositories
      - note_repository.dart
  - views
    - add_note_view.dart
    - edit_note_view.dart
    - home_view.dart
  - main.dart

*/