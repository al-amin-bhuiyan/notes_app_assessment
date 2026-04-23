import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_assessment/core/constants/route_paths.dart';
import 'package:notes_app_assessment/app/router/app_routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    redirect: _handleRedirect,
    routes: AppRoutes.routes,
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