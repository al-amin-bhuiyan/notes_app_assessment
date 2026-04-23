import 'package:get/get.dart';
import 'package:notes_app_assessment/core/services/auth_service.dart';
import 'package:notes_app_assessment/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:notes_app_assessment/features/auth/domain/usecases/login_usecase.dart';
import 'package:notes_app_assessment/features/auth/domain/usecases/register_usecase.dart';
import 'package:notes_app_assessment/features/auth/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);

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
  }
}
