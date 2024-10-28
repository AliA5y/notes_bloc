import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/note_model.dart';
import '../../data/repositories/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc(this.noteRepository) : super(NoteInitial()) {
    on<NoteEvent>((event, emit) async {
      if (event is Initial) {
        emit(NoteLoading());
        try {
          final List<NoteModel> notes = await noteRepository.getAllNotes();
          emit(NoteLoadSuccess(notes));
        } catch (e) {
          emit(NoteOperationFailure("Failed to fetch notes: $e"));
        }
      } else if (event is AddNote) {
        emit(NoteLoading());

        try {
          await noteRepository.addNote(
            NoteModel(
              title: event.title,
              content: event.content,
              language: event.language,
              timeStamp: event.timeStamp,
              dateStamp: event.dateStamp,
            ),
          );
          final List<NoteModel> notes = await noteRepository.getAllNotes();
          emit(NoteLoadSuccess(notes));
        } catch (e) {
          emit(NoteOperationFailure("Failed to add note: $e"));
        }
      } else if (event is UpdateNote) {
        emit(NoteLoading());

        try {
          await noteRepository.updateNote(
            NoteModel(
              id: event.id,
              title: event.title,
              content: event.content,
              language: event.language,
              timeStamp: event.timeStamp,
              dateStamp: event.dateStamp,
            ),
          );
          final List<NoteModel> notes = await noteRepository.getAllNotes();
          emit(NoteLoadSuccess(notes));
        } catch (e) {
          emit(NoteOperationFailure("Failed to update note: $e"));
        }
      } else if (event is DeleteNote) {
        emit(NoteLoading());
        try {
          await noteRepository.deleteNote(event.id);
          final List<NoteModel> notes = await noteRepository.getAllNotes();
          emit(NoteLoadSuccess(notes));
        } catch (e) {
          emit(NoteOperationFailure("Failed to delete note: $e"));
        }
      } else if (event is DeleteNoteList) {
        emit(NoteLoading());
        try {
          await noteRepository.deleteNotesList(event.ids);
          final List<NoteModel> notes = await noteRepository.getAllNotes();
          emit(NoteLoadSuccess(notes));
        } catch (e) {
          emit(NoteOperationFailure("Failed to delete notes: $e"));
        }
      }
    });
  }
}
