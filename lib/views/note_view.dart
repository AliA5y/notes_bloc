import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';
import '../data/models/note_model.dart';

class NotePage extends StatefulWidget {
  final NoteModel? note;

  const NotePage({super.key, this.note});

  @override
  NotePageState createState() => NotePageState();
}

class NotePageState extends State<NotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              maxLines: null,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;

                if (widget.note == null) {
                  final dateTime = MyDateTime.fromDateTime(DateTime.now());
                  BlocProvider.of<NoteBloc>(context).add(AddNote(
                    title: title,
                    content: content,
                    language: Intl.getCurrentLocale(),
                    timeStamp: dateTime.time,
                    dateStamp: dateTime.date,
                  ));
                } else {
                  BlocProvider.of<NoteBloc>(context).add(
                    UpdateNote(
                      id: widget.note!.id!,
                      title: title,
                      content: content,
                      language: widget.note!.language,
                      timeStamp: widget.note!.timeStamp,
                      dateStamp: widget.note!.dateStamp,
                    ),
                  );
                }

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
