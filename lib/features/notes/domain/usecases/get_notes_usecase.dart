import 'package:notes_app/features/notes/domain/entities/note_entity.dart';
import 'package:notes_app/features/notes/domain/repositories/notes_repository.dart';

class GetNotesUseCase {
  final NotesRepository _repository;

  GetNotesUseCase({required NotesRepository repository})
      : _repository = repository;

  Stream<List<NoteEntity>> execute() {
    return _repository.getNotes();
  }
}