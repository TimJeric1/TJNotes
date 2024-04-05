import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tjnotes/core/navigation/router.dart';
import 'package:tjnotes/features/note_managment/presentation/providers/note_managment_provider.dart';


class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteManagmentNotifierProvider);

    ref.listen(noteManagmentNotifierProvider, (previousUser, notes) {
      if (notes.hasError) {
        final error = notes.asError?.error;
        if (error == null) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('An error has occurred: ${error.toString()}')));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: notes.isLoading ? 0.5 : 1.0,
            child: notes.hasValue && notes.value != null && notes.value!.isNotEmpty
                ? ListView.builder(
                    itemCount: notes.value!.length,
                    itemBuilder: (context, index) {
                      // Get the note at the current index
                      final note = notes.value![index];
                      // Display the note in a ListTile
                      return ListTile(
                        title: Text(note.title),
                        subtitle: Text(note.content),
                        onTap: (){context.push('$EDIT_NOTE_PAGE_PATH/${note.uuid}');},
                      );
                    },
                  )
                : const Center(child: Text("It seems like you don't have any notes..."),),
          ),
          if (notes.isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(EDIT_NOTE_PAGE_PATH);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
