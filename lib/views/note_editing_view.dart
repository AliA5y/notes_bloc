import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_bloc/blocs/home/home_bloc.dart';
import 'package:notes_bloc/blocs/home/home_event.dart';
import 'package:notes_bloc/cubits/language_cubit/language_cubit.dart';
import 'package:notes_bloc/generated/l10n.dart';
import 'package:notes_bloc/shared.dart';

import '../data/models/note_model.dart';

const languages = ['عربي', 'English'];

class NoteEditingView extends StatefulWidget {
  final NoteModel? note;
  static const id = 'noteEditing';

  const NoteEditingView({super.key, this.note});

  @override
  NoteEditingViewState createState() => NoteEditingViewState();
}

class NoteEditingViewState extends State<NoteEditingView> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String language;

  @override
  void initState() {
    language = Intl.getCurrentLocale();
    super.initState();

    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null
            ? S.of(context).addNote
            : S.of(context).EditNote),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: S.of(context).noteTitle,
                    ),
                  ),
                ),
                widget.note == null
                    ? GestureDetector(
                        onTapDown: (details) {
                          final offset = details.globalPosition;
                          showMenu(
                            context: context,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            position: RelativeRect.fromLTRB(
                                offset.dx,
                                offset.dy,
                                MediaQuery.sizeOf(context).width - offset.dx,
                                MediaQuery.sizeOf(context).height - offset.dy),
                            items: List.generate(
                              2,
                              (index) {
                                return PopupMenuItem(
                                  onTap: () {
                                    language = index == 0
                                        ? 'ar'
                                        : languages[index]
                                            .substring(0, 2)
                                            .toLowerCase();
                                    log(language);
                                    if (!isArabic() && language == 'ar') {
                                      context
                                          .read<LanguageCubit>()
                                          .changeLanguage(language);
                                    } else if (isArabic() && language == 'en') {
                                      context
                                          .read<LanguageCubit>()
                                          .changeLanguage(language);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      languages[index],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.language,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: S.of(context).noteText,
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 56,
              child: MaterialButton(
                onPressed: _handleSubmition,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Center(
                    child:
                        Text(S.of(context).save, style: Styles.headlineMedium)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmition() {
    final title = _titleController.text;
    final content = _contentController.text;
    log("${title.length}\n${content.length}");
    if (widget.note == null) {
      if (title.isNotEmpty || content.isNotEmpty) {
        final dateTime = MyDateTime.fromDateTime(DateTime.now());
        BlocProvider.of<NoteBloc>(context).add(
          AddNote(
              title: title,
              content: content,
              language: language,
              timeStamp: dateTime.time,
              dateStamp: dateTime.date),
        );
      }
    } else {
      BlocProvider.of<NoteBloc>(context).add(UpdateNote(
        id: widget.note!.id!,
        title: title,
        content: content,
        language: language,
        timeStamp: widget.note!.timeStamp,
        dateStamp: widget.note!.dateStamp,
      ));
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
