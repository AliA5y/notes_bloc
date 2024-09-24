import 'package:flutter/material.dart';
import 'package:notes_bloc/data/models/note_model.dart';

class NoteItemTile extends StatelessWidget {
  const NoteItemTile(
      {super.key,
      required this.note,
      this.onEdit,
      this.onDelete,
      this.onDisplay});
  final NoteModel note;
  final void Function()? onDelete;
  final void Function()? onDisplay;
  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        title: Text(note.title),
        subtitle: Text(note.content),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
          ],
        ),
        onTap: onDisplay,
      ),
    );
  }
}
