import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/errors/app_exception.dart';
import 'package:notes_app/core/utils/toast_message.dart';
import 'package:notes_app/features/notes/domain/entities/note_entity.dart';
import 'package:notes_app/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:notes_app/features/notes/domain/usecases/get_notes_usecase.dart';

class NotesController extends GetxController {
  final AddNoteUseCase _addNoteUseCase;
  final GetNotesUseCase _getNotesUseCase;

  NotesController({
    required AddNoteUseCase addNoteUseCase,
    required GetNotesUseCase getNotesUseCase,
  })  : _addNoteUseCase = addNoteUseCase,
        _getNotesUseCase = getNotesUseCase;

  // Form
  final addNoteFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // Observable states
  final RxList<NoteEntity> notes = <NoteEntity>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToNotes();
  }

  void _listenToNotes() {
    isLoading.value = true;
    _getNotesUseCase.execute().listen(
      (noteList) {
        notes.assignAll(noteList);
        isLoading.value = false;
        hasError.value = false;
      },
      onError: (error, stackTrace) {
        debugPrint('STREAM ERROR: $error');
        debugPrint('STACKTRACE: $stackTrace');
        isLoading.value = false;
        hasError.value = true;
        if (error is AppException) {
          errorMessage.value = error.message;
        } else {
          errorMessage.value = 'Failed to load notes. Please try again. \nError: $error';
        }
      },
    );
  }

  Future<void> addNote(BuildContext context) async {
    if (!addNoteFormKey.currentState!.validate()) return;

    isSaving.value = true;
    try {
      await _addNoteUseCase.execute(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
      );
      ToastMessage.success('Note saved successfully!');
      _clearForm();
      if (context.mounted) Navigator.of(context).pop();
    } on AppException catch (e) {
      ToastMessage.error(e.message);
    } finally {
      isSaving.value = false;
    }
  }

  void _clearForm() {
    titleController.clear();
    descriptionController.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}