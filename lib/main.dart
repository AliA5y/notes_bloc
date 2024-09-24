import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/data/repositories/home_repository.dart';
import 'package:notes_bloc/views/home_view.dart';
import 'blocs/home/home_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    NoteRepository repo = NoteRepository.instance;
    return BlocProvider(
      create: (context) {
        return NoteBloc(repo);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
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