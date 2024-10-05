import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/generated/l10n.dart';
import 'package:notes_bloc/views/display_note_view.dart';
import 'package:notes_bloc/views/widgets/app_logo_button.dart';
import 'package:notes_bloc/views/widgets/note_item_tile.dart';

import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';
import '../blocs/home/home_state.dart';
import '../data/models/note_model.dart';
import 'note_editing_view.dart';
import 'widgets/notes_app_drawer.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  bool hasInitialized = false;
  static const id = 'home';

  @override
  Widget build(BuildContext context) {
    if (!hasInitialized) {
      BlocProvider.of<NoteBloc>(context).add(Initial());
      hasInitialized = true;
    }
    return Scaffold(
      drawer: const NotesAppDrawer(),
      appBar: AppBar(
        toolbarHeight: 64,
        leadingWidth: 64,
        iconTheme: const IconThemeData(size: 34),
        actions: const [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.0, bottom: 6),
                child: AppLogoButton(),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],

        title: Text(S.of(context).myNotes),
        // actions: [],
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is NoteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NoteLoadSuccess) {
              final List<NoteModel> notes = state.notes;

              if (notes.isEmpty) {
                return Center(
                  child: Text(S.of(context).emptyNotes),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteItemTile(
                    note: note,
                    onEdit: () {
                      _navigateToNoteEditingView(context, note);
                    },
                    onDelete: () {
                      BlocProvider.of<NoteBloc>(context)
                          .add(DeleteNote(id: note.id!));
                    },
                    onDisplay: () {
                      _navigateToDisplayNoteView(context, note);
                    },
                  );
                },
              );
            } else if (state is NoteOperationFailure) {
              return Center(
                child:
                    Text('${S.of(context).loadError}\n${state.errorMessage}'),
              );
            } else {
              log(state.toString());
              return Center(
                child: Text(S.of(context).loadError),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _navigateToNoteEditingView(context, null);
        },
      ),
    );
  }

  void _navigateToNoteEditingView(BuildContext context, NoteModel? note) {
    final noteBloc = context.read<NoteBloc>();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: noteBloc,
        child: NoteEditingView(note: note),
      ),
    ));
  }

  void _navigateToDisplayNoteView(BuildContext context, NoteModel note) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DisplayNoteView(note: note),
    ));
  }
}
