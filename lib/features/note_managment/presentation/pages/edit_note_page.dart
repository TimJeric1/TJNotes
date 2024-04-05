import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tjnotes/core/util/debounce.dart';
import 'package:tjnotes/features/note_managment/presentation/providers/note_managment_provider.dart';

import '../../domain/entities/note_entity.dart';

class EditNotePage extends ConsumerWidget {
  final String? noteUuid;

  const EditNotePage({
    Key? key,
    this.noteUuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Note? note;
    if (noteUuid == null)
      note = Note(title: '', content: '');
    else
      note = ref
          .read(noteManagmentNotifierProvider.notifier)
          .getNoteByUuid(uuid: noteUuid!);

    TextEditingController titleController =
        TextEditingController(text: note?.title);
    TextEditingController contentController =
        TextEditingController(text: note?.content);

    void updateNote() {
      ref.read(debouncerProvider).run(
        () {
          final updatedNote = Note(
            uuid: note?.uuid,
            title: titleController.text,
            content: contentController.text,
          );
          ref
              .read(noteManagmentNotifierProvider.notifier)
              .addOrUpdateNote(note: updatedNote);
        },
        const Duration(milliseconds: 500),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: note == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Couldn't find that note. Please try again"),
                  OutlinedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Back')),
                ],
              ),
            )
          : Theme(
              data: Theme.of(context).copyWith(
                  inputDecorationTheme:
                      const InputDecorationTheme(border: InputBorder.none)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      onChanged: (_) {
                        updateNote();
                      },
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Title',
                      ),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: TextField(
                        onChanged: (_) {
                          updateNote();
                        },
                        controller: contentController,
                        decoration: const InputDecoration(
                          hintText: 'Enter Content',
                        ),
                        maxLines: null, // Allows multiple lines for content
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
