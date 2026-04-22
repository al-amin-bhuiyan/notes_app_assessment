import 'package:notes_app/features/notes/domain/entities/note_entity.dart';

abstract class NotesRepository {
  Future<void> addNote({
    required String title,
    required String description,
  });

  Stream<List<NoteEntity>> getNotes();
}