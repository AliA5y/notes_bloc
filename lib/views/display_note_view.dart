import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/models/note_model.dart';

class DisplayNoteView extends StatelessWidget {
  final NoteModel note;
  static const id = 'displayNote';

  const DisplayNoteView({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return SelectableRegion(
      selectionControls: MaterialTextSelectionControls(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            note.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
        ),
        body: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(16),
              ),
              margin: EdgeInsets.all(8),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        child: Text(
                          note.content,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withAlpha(80)),
              child: InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(
                          text: '${note.title}\n\n${note.content}'))
                      .then(
                    (_) {
                      // if (context.mounted) {
                      //   Tools.showCustomSnackbar(context,
                      //       message: S.of(context).copied,
                      //       type: NotificationType.success);
                      // }
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.copy,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
