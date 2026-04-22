import 'package:go_router/go_router.dart';
import 'package:notes_app/core/constants/route_paths.dart';
import 'package:notes_app/features/auth/presentation/bindings/auth_binding.dart';
import 'package:notes_app/features/auth/presentation/pages/login_page.dart';
import 'package:notes_app/features/auth/presentation/pages/registration_page.dart';
import 'package:notes_app/features/notes/presentation/bindings/notes_binding.dart';
import 'package:notes_app/features/notes/presentation/pages/add_note_page.dart';
import 'package:notes_app/features/notes/presentation/pages/home_page.dart';
import 'package:notes_app/features/splash/presentation/bindings/splash_binding.dart';
import 'package:notes_app/features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  AppRoutes._();

  static final List<GoRoute> routes = [
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) {
        SplashBinding().dependencies();
        return const SplashPage();
      },
    ),
    GoRoute(
      path: RoutePaths.login,
      builder: (context, state) {
        AuthBinding().dependencies();
        return const LoginPage();
      },
    ),
    GoRoute(
      path: RoutePaths.register,
      builder: (context, state) {
        AuthBinding().dependencies();
        return const RegistrationPage();
      },
    ),
    GoRoute(
      path: RoutePaths.home,
      builder: (context, state) {
        NotesBinding().dependencies();
        return const HomePage();
      },
    ),
    GoRoute(
      path: RoutePaths.addNote,
      builder: (context, state) {
        return const AddNotePage();
      },
    ),
  ];
}
