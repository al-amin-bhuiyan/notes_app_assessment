import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/core/constants/route_paths.dart';
import 'package:notes_app/core/services/user_session_service.dart';
import 'package:notes_app/features/auth/presentation/bindings/auth_binding.dart';
import 'package:notes_app/features/auth/presentation/pages/login_page.dart';
import 'package:notes_app/features/auth/presentation/pages/registration_page.dart';
import 'package:notes_app/features/notes/presentation/bindings/notes_binding.dart';
import 'package:notes_app/features/notes/presentation/pages/add_note_page.dart';
import 'package:notes_app/features/notes/presentation/pages/home_page.dart';
import 'package:notes_app/features/splash/presentation/bindings/splash_binding.dart';
import 'package:notes_app/features/splash/presentation/pages/splash_page.dart';
import 'package:get/get.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    redirect: _handleRedirect,
    routes: [
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
    ],
  );

  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final String currentPath = state.matchedLocation;

    final bool isOnSplash = currentPath == RoutePaths.splash;
    final bool isOnAuth = currentPath == RoutePaths.login ||
        currentPath == RoutePaths.register;

    // Let splash handle its own routing logic
    if (isOnSplash) return null;

    // If logged in and trying to access auth pages, redirect to home
    if (isLoggedIn && isOnAuth) return RoutePaths.home;

    // If not logged in and trying to access protected pages, redirect to login
    if (!isLoggedIn && !isOnAuth) return RoutePaths.login;

    return null;
  }
}