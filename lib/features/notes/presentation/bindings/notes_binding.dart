import 'package:get/get.dart';
import 'package:notes_app_assessment/core/services/auth_service.dart';
import 'package:notes_app_assessment/core/services/firestore_service.dart';
import 'package:notes_app_assessment/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:notes_app_assessment/features/auth/presentation/controllers/auth_controller.dart';
import 'package:notes_app_assessment/features/auth/domain/usecases/login_usecase.dart';
import 'package:notes_app_assessment/features/auth/domain/usecases/register_usecase.dart';
import 'package:notes_app_assessment/features/notes/data/repositories/notes_repository_impl.dart';
import 'package:notes_app_assessment/features/notes/domain/usecases/add_note_usecase.dart';
import 'package:notes_app_assessment/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:notes_app_assessment/features/notes/presentation/controllers/notes_controller.dart';

class NotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);
    Get.lazyPut<FirestoreService>(() => FirestoreService(), fenix: true);

    Get.lazyPut<AuthRepositoryImpl>(
          () => AuthRepositoryImpl(authService: Get.find<AuthService>()),
      fenix: true,
    );

    Get.lazyPut<LoginUseCase>(
          () => LoginUseCase(repository: Get.find<AuthRepositoryImpl>()),
      fenix: true,
    );

    Get.lazyPut<RegisterUseCase>(
          () => RegisterUseCase(repository: Get.find<AuthRepositoryImpl>()),
      fenix: true,
    );

    Get.lazyPut<AuthController>(
          () => AuthController(
        loginUseCase: Get.find<LoginUseCase>(),
        registerUseCase: Get.find<RegisterUseCase>(),
        authRepositoryImpl: Get.find<AuthRepositoryImpl>(),
      ),
      fenix: true,
    );

    Get.lazyPut<NotesRepositoryImpl>(
          () => NotesRepositoryImpl(
        firestoreService: Get.find<FirestoreService>(),
        authService: Get.find<AuthService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<AddNoteUseCase>(
          () => AddNoteUseCase(repository: Get.find<NotesRepositoryImpl>()),
      fenix: true,
    );

    Get.lazyPut<GetNotesUseCase>(
          () => GetNotesUseCase(repository: Get.find<NotesRepositoryImpl>()),
      fenix: true,
    );

    Get.lazyPut<NotesController>(
          () => NotesController(
        addNoteUseCase: Get.find<AddNoteUseCase>(),
        getNotesUseCase: Get.find<GetNotesUseCase>(),
      ),
      fenix: true,
    );
  }
}
