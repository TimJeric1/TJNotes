import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tjnotes/features/note_managment/data/repositories/note_repository_impl.dart';
import 'package:tjnotes/features/note_managment/domain/entities/note_entity.dart';
import 'package:tjnotes/features/note_managment/domain/repositories/note_repository.dart';

part 'delete_note.g.dart';

@riverpod
DeleteNote deleteNote(DeleteNoteRef ref) {
  final noteRepository = ref.read(noteRepositoryProvider);
  return DeleteNote(noteRepository);
}


class DeleteNote {
  final NoteRepository _noteRepository;

  DeleteNote(this._noteRepository);

  Future<void> call(Note note) async {
    return await _noteRepository.deleteNote(note);
  }

}