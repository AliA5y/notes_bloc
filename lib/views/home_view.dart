import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/views/widgets/note_item_tile.dart';

import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';
import '../blocs/home/home_state.dart';
import '../data/models/note_model.dart';
import 'note_editing_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  bool hasInitialized = false;

  @override
  Widget build(BuildContext context) {
    if (!hasInitialized) {
      BlocProvider.of<NoteBloc>(context).add(Initial());
      hasInitialized = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NoteLoadSuccess) {
            final List<NoteModel> notes = state.notes;

            if (notes.isEmpty) {
              return const Center(
                child: Text('No notes found'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteItemTile(
                  note: note,
                  onEdit: () {
                    _navigateToNoteDetail(context, note);
                  },
                  onDelete: () {
                    BlocProvider.of<NoteBloc>(context)
                        .add(DeleteNote(id: note.id!));
                  },
                  onDisplay: () {
                    // todo: add navigating to display note
                  },
                );
              },
            );
          } else if (state is NoteOperationFailure) {
            return Center(
              child: Text('Failed to load notes: ${state.errorMessage}'),
            );
          } else {
            log(state.toString());
            return const Center(
              child: Text('Unknown error'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _navigateToNoteDetail(context, null);
        },
      ),
    );
  }

  void _navigateToNoteDetail(BuildContext context, NoteModel? note) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NoteEditingView(note: note),
    ));
  }
}
