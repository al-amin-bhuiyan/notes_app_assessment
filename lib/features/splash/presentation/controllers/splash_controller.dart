import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/constants/route_paths.dart';
import 'package:notes_app/features/splash/domain/usecases/check_first_launch_usecase.dart';

import 'package:notes_app/app/router/app_router.dart';

class SplashController extends GetxController {
  final CheckFirstLaunchUseCase _checkFirstLaunchUseCase;

  SplashController({
    required CheckFirstLaunchUseCase checkFirstLaunchUseCase,
  }) : _checkFirstLaunchUseCase = checkFirstLaunchUseCase;

  @override
  void onInit() {
    super.onInit();
    _handleSplash();
  }

  Future<void> _handleSplash() async {
    final bool isFirst = await _checkFirstLaunchUseCase.execute();

    if (isFirst) {
      // Show splash for 2.5 seconds on first launch
      await Future.delayed(const Duration(milliseconds: 2500));
      await _checkFirstLaunchUseCase.markLaunched();
    }

    _navigateNext();
  }

  void _navigateNext() {
    final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

    if (isLoggedIn) {
      AppRouter.router.go(RoutePaths.home);
    } else {
      AppRouter.router.go(RoutePaths.login);
    }
  }
}