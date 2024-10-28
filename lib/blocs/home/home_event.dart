abstract class NoteEvent {}

class Initial extends NoteEvent {}

class FetchNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final String title;
  final String content;
  final String language;
  final String timeStamp;
  final String dateStamp;

  AddNote({
    required this.timeStamp,
    required this.language,
    required this.title,
    required this.content,
    required this.dateStamp,
  });
}

class UpdateNote extends NoteEvent {
  final int id;
  final String title;
  final String content;
  final String language;
  final String timeStamp;
  final String dateStamp;

  UpdateNote({
    required this.language,
    required this.id,
    required this.title,
    required this.content,
    required this.timeStamp,
    required this.dateStamp,
  });
}

class DeleteNote extends NoteEvent {
  final int id;

  DeleteNote({required this.id});
}

class DeleteNoteList extends NoteEvent {
  final List<int> ids;
  DeleteNoteList({required this.ids});
}
