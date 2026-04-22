import 'package:notes_app/core/services/user_session_service.dart';
import 'package:notes_app/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final UserSessionService _sessionService;

  SplashRepositoryImpl({required UserSessionService sessionService})
      : _sessionService = sessionService;

  @override
  Future<bool> isFirstLaunch() async {
    return _sessionService.isFirstLaunch;
  }

  @override
  Future<void> markAsLaunched() async {
    await _sessionService.markLaunched();
  }
}