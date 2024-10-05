import 'package:flutter/material.dart';

import '../data/models/note_model.dart';

class DisplayNoteView extends StatelessWidget {
  final NoteModel note;
  static const id = 'displayNote';

  const DisplayNoteView({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          note.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SizedBox(
                child: Text(
                  note.content,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
