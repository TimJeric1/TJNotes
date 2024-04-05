import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tjnotes/features/note_managment/data/repositories/note_repository_impl.dart';
import 'package:tjnotes/features/note_managment/domain/entities/note_entity.dart';
import 'package:tjnotes/features/note_managment/domain/repositories/note_repository.dart';

part 'add_note.g.dart';

@riverpod
AddNote addNote(AddNoteRef ref) {
  final noteRepository = ref.read(noteRepositoryProvider);
  return AddNote(noteRepository);
}


class AddNote {
  final NoteRepository _noteRepository;

  AddNote(this._noteRepository);

  Future<void> call(Note note) async {
    return await _noteRepository.addOrUpdateNote(note);
  }

}