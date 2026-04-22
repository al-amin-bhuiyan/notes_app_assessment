import 'package:get/get.dart';
import 'package:notes_app/core/services/user_session_service.dart';
import 'package:notes_app/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:notes_app/features/splash/domain/usecases/check_first_launch_usecase.dart';
import 'package:notes_app/features/splash/presentation/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashRepositoryImpl>(
          () => SplashRepositoryImpl(
        sessionService: Get.find<UserSessionService>(),
      ),
      fenix: true,
    );

    Get.lazyPut<CheckFirstLaunchUseCase>(
          () => CheckFirstLaunchUseCase(
        repository: Get.find<SplashRepositoryImpl>(),
      ),
      fenix: true,
    );

    Get.lazyPut<SplashController>(
          () => SplashController(
        checkFirstLaunchUseCase: Get.find<CheckFirstLaunchUseCase>(),
      ),
      fenix: true,
    );
  }
}