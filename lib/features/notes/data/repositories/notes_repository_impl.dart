

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/firestore_service.dart';
import '../../domain/entities/note_entity.dart';
import '../../domain/repositories/notes_repository.dart';
import '../models/note_model.dart';

class NotesRepositoryImpl implements NotesRepository {
  final FirestoreService _firestoreService;
  final AuthService _authService;

  NotesRepositoryImpl({
    required FirestoreService firestoreService,
    required AuthService authService,
  })  : _firestoreService = firestoreService,
        _authService = authService;

  String get _currentUserId => _authService.currentUser!.uid;

  @override
  Future<void> addNote({
    required String title,
    required String description,
  }) async {
    final note = NoteModel(
      id: '',
      userId: _currentUserId,
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    await _firestoreService.addDocument(
      collectionPath: ApiConstants.notesCollection,
      data: note.toFirestore(),
    );
  }

  @override
  Stream<List<NoteEntity>> getNotes() {
    return _firestoreService
        .streamDocuments(
      collectionPath: ApiConstants.notesCollection,
      filters: [
        QueryFilter(
          field: ApiConstants.fieldUserId,
          isEqualTo: _currentUserId,
        ),
      ],
    )
        .map((snapshot) {
      final notes = snapshot.docs
          .map((doc) => NoteModel.fromFirestore(
                doc as DocumentSnapshot<Map<String, dynamic>>,
              ).toEntity())
          .toList();

      // Sort locally to avoid needing a Firestore composite index
      notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return notes;
    });
  }
}