import 'package:notes_app_assessment/features/splash/domain/repositories/splash_repository.dart';

class CheckFirstLaunchUseCase {
  final SplashRepository _repository;

  CheckFirstLaunchUseCase({required SplashRepository repository})
      : _repository = repository;

  Future<bool> execute() => _repository.isFirstLaunch();

  Future<void> markLaunched() => _repository.markAsLaunched();
}
