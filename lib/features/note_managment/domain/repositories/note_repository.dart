



import 'package:tjnotes/features/note_managment/domain/entities/note_entity.dart';

abstract interface class NoteRepository {

  Stream<List<Note>> getNotesStream();

  Future<void> addOrUpdateNote(Note note);

  Future<void> deleteNote(Note note);


}