abstract class SplashRepository {
  Future<bool> isFirstLaunch();
  Future<void> markAsLaunched();
}