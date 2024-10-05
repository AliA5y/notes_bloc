import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/cubits/theme_cubit/theme_cubit.dart';
import 'package:notes_bloc/data/repositories/home_repository.dart';
import 'package:notes_bloc/views/home_view.dart';
import 'package:notes_bloc/views/splash_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'blocs/home/home_bloc.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
  }
  // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
  // this step, it will use the sqlite version available on the system.
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    NoteRepository repo = NoteRepository.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, Brightness>(
        builder: (context, brightnessState) {
          return MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: brightnessState,
            ),
            home: const SplashScreen(),
            routes: {
              HomeView.id: (context) => BlocProvider(
                    create: (context) => NoteBloc(repo),
                    child: HomeView(),
                  )
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