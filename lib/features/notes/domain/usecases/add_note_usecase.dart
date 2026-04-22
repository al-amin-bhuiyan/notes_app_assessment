import 'package:notes_app/features/notes/domain/repositories/notes_repository.dart';

class AddNoteUseCase {
  final NotesRepository _repository;

  AddNoteUseCase({required NotesRepository repository})
      : _repository = repository;

  Future<void> execute({
    required String title,
    required String description,
  }) {
    return _repository.addNote(title: title, description: description);
  }
}