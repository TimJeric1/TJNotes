import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tjnotes/features/note_managment/domain/entities/note_entity.dart';
import 'package:tjnotes/features/note_managment/domain/usecases/add_note.dart';
import 'package:tjnotes/features/note_managment/domain/usecases/delete_note.dart';
import 'package:tjnotes/features/note_managment/domain/usecases/get_notes_stream.dart';


part 'note_managment_provider.g.dart';

@riverpod
class NoteManagmentNotifier extends _$NoteManagmentNotifier {
  late GetNotesStream _getNotesStream;
  late AddNote _addOrUpdateNote;
  late DeleteNote _deleteNote;

  @override
  Stream<List<Note>> build() {
    _addOrUpdateNote = ref.read(addNoteProvider);
    _getNotesStream = ref.read(getNotesStreamProvider);
    _deleteNote = ref.read(deleteNoteProvider);

    return _getNotesStream();
  }

  Future<void> addOrUpdateNote({required Note note}) async {
    await _addOrUpdateNote.call(note);
  }
  Future<void> deleteNote({required Note note}) async {
    await _deleteNote.call(note);
  }

  Note? getNoteByUuid({required String uuid}){
    var note = state.value?.singleWhere((element) => element.uuid == uuid);
    return note;
  }



}
