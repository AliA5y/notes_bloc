import '../../data/models/note_model.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoadSuccess extends NoteState {
  final List<NoteModel> notes;

  NoteLoadSuccess(this.notes);
}

class NoteOperationSuccess extends NoteState {}

class NoteOperationFailure extends NoteState {
  final String errorMessage;

  NoteOperationFailure(this.errorMessage);
}
