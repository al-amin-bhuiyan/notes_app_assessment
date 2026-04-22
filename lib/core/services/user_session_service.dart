import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes_app/core/constants/app_paths.dart';

class UserSessionService extends GetxService {
  late SharedPreferences _prefs;

  Future<UserSessionService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  bool get isFirstLaunch => _prefs.getBool(AppPaths.hasLaunchedKey) ?? true;

  Future<void> markLaunched() async {
    await _prefs.setBool(AppPaths.hasLaunchedKey, false);
  }

  Future<void> clearSession() async {
    await _prefs.clear();
  }
}