import 'package:flutter/material.dart';
import 'package:notes_bloc/data/models/note_model.dart';
import 'package:notes_bloc/shared.dart';

class NoteItemTile extends StatelessWidget {
  const NoteItemTile(
      {super.key,
      required this.note,
      this.onEdit,
      this.onDelete,
      this.onDisplay,
      this.onLongPress,
      required this.isSelectionMode});
  final NoteModel note;
  final void Function()? onDelete;
  final void Function()? onDisplay;
  final void Function()? onEdit;
  final void Function()? onLongPress;
  final bool isSelectionMode;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          note.language == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      child: MaterialButton(
        onLongPress: onLongPress,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(0),
        onPressed: onDisplay,
        child: SizedBox(
          height: 142,
          child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(note.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.headlineMedium),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              note.content,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: isSelectionMode
                                  ? [const SizedBox()]
                                  : [
                                      IconButton(
                                        icon:
                                            const Icon(Icons.delete, size: 32),
                                        onPressed: onDelete,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit, size: 32),
                                        onPressed: onEdit,
                                      ),
                                    ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  note.timeStamp,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                Text(
                                  note.dateStamp,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
