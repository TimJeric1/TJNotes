
import 'package:uuid/uuid.dart';

class Note {
  final String uuid;
  final String title;
  final String content;

  Note({required this.title, required this.content, String? uuid})
      : uuid = uuid ?? const Uuid().v4();
}
