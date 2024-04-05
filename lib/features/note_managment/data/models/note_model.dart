

import 'package:tjnotes/features/note_managment/domain/entities/note_entity.dart';

class NoteModel extends Note {

  NoteModel({required super.title, required super.content, String? super.uuid});



  factory NoteModel.fromNote(Note note) {
    return NoteModel(uuid: note.uuid ,title: note.title, content: note.content);
  }


  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      uuid: map['uuid'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }

  Map<String, String> toMap() {
    return {
      'uuid': uuid,
      'title': title,
      'content': content,
    };
  }


}
