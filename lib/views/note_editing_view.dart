import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/blocs/home/home_bloc.dart';
import 'package:notes_bloc/blocs/home/home_event.dart';

import '../data/models/note_model.dart';

class NoteEditingView extends StatefulWidget {
  final NoteModel? note;

  const NoteEditingView({super.key, this.note});

  @override
  NoteEditingViewState createState() => NoteEditingViewState();
}

class NoteEditingViewState extends State<NoteEditingView> {
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
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Content',
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 56,
              child: MaterialButton(
                onPressed: () {
                  final title = _titleController.text;
                  final content = _contentController.text;

                  if (widget.note == null) {
                    BlocProvider.of<NoteBloc>(context).add(AddNote(
                      title: title,
                      content: content,
                    ));
                  } else {
                    BlocProvider.of<NoteBloc>(context).add(UpdateNote(
                      id: widget.note!.id!,
                      title: title,
                      content: content,
                    ));
                  }

                  Navigator.of(context).pop();
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const Center(child: Text('Save')),
              ),
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
