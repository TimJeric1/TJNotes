


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tjnotes/features/auth/presentation/providers/auth_provider.dart';
import 'package:tjnotes/features/note_managment/data/models/note_model.dart';
import 'package:tjnotes/features/note_managment/domain/entities/note_entity.dart';
import 'package:tjnotes/features/note_managment/domain/repositories/note_repository.dart';

part 'note_repository_impl.g.dart';

@riverpod
FirebaseFirestore firebaseFirestore (FirebaseFirestoreRef ref) {
  return FirebaseFirestore.instance;
}

@riverpod
NoteRepository noteRepository (NoteRepositoryRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final user = ref.watch(authNotifierProvider).value;
  return NoteRepositoryImpl(firestore, user!);
}

class NoteRepositoryImpl implements NoteRepository {

  final FirebaseFirestore _firestore;
  final User _user;

  NoteRepositoryImpl(this._firestore, this._user);

  @override
  Stream<List<Note>> getNotesStream() {
    final collectionRef = _firestore.collection('users').doc(_user.uid).collection('notes'); // Reference to the "notes" collection


    // Create a StreamController to manage the stream
    StreamController<List<Note>> controller = StreamController<List<Note>>();

    // Listen for snapshots and add data to the stream
    collectionRef.snapshots().listen((event) {
      List<Note> notes = [];
      // Loop through the documents in the collection
      for (var doc in event.docs) {
        // Convert each document to a NoteModel object
        NoteModel note = NoteModel.fromMap(doc.data());
        notes.add(note);
      }
      // Add the list of notes to the stream
      controller.add(notes);
    });

    // Return the stream
    return controller.stream;
  }


  @override
  Future<void> addOrUpdateNote(Note note) async {
    final noteModel = NoteModel.fromNote(note);
    final docRef = _firestore.collection('users').doc(_user.uid).collection('notes').doc(noteModel.uuid);
    await docRef.set(noteModel.toMap());
  }

  @override
  Future<void> deleteNote(Note note) async {
    final docRef = _firestore.collection('users').doc(_user.uid).collection('notes').doc(note.uuid);
    await docRef.delete();
  }

  Future<void> createCollectionIfNotExists(String collectionPath) async {
    final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection(collectionPath);

    final doc = await collectionReference.doc().get();
    if (!doc.exists) {
      await collectionReference.add({});
    }
  }

}