import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/cubits/language_cubit/language_cubit.dart';
import 'package:notes_bloc/cubits/theme_cubit/theme_cubit.dart';
import 'package:notes_bloc/data/repositories/home_repository.dart';
import 'package:notes_bloc/views/edit_profile_view.dart';
import 'package:notes_bloc/views/home_view.dart';
import 'package:notes_bloc/views/splash_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'blocs/home/home_bloc.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
    // this step, it will use the sqlite version available on the system.
    databaseFactory = databaseFactoryFfi;
  }
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
                home: const SplashScreen(),
                routes: {
                  EditProfileView.id: (context) => const EditProfileView(),
                  HomeView.id: (context) => BlocProvider(
                        create: (context) => NoteBloc(repo),
                        child: HomeView(),
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