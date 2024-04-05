import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tjnotes/features/note_managment/data/repositories/note_repository_impl.dart';
import 'package:tjnotes/features/note_managment/domain/entities/note_entity.dart';
import 'package:tjnotes/features/note_managment/domain/repositories/note_repository.dart';

part 'get_notes_stream.g.dart';

@riverpod
GetNotesStream getNotesStream(GetNotesStreamRef ref) {
  final noteRepository = ref.read(noteRepositoryProvider);
  return GetNotesStream(noteRepository);
}


class GetNotesStream {
  final NoteRepository _noteRepository;

  GetNotesStream(this._noteRepository);

  Stream<List<Note>> call() {
    return _noteRepository.getNotesStream();
  }

}