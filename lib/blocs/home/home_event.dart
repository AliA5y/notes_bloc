abstract class NoteEvent {}

class Initial extends NoteEvent {}

class FetchNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final String title;
  final String content;

  AddNote({required this.title, required this.content});
}

class UpdateNote extends NoteEvent {
  final int id;
  final String title;
  final String content;

  UpdateNote({required this.id, required this.title, required this.content});
}

class DeleteNote extends NoteEvent {
  final int id;

  DeleteNote({required this.id});
}
