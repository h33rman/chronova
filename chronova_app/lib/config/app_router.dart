// File: lib/config/app_router.dart

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:chronova_app/services/auth_gate.dart';
import 'package:chronova_app/screens/home_screen.dart';

// Import your other screens
import 'package:chronova_app/screens/registration_screen.dart';
import '../screens/login_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/profile_screen.dart';

// GoRouter configuration
final GoRouter appRouter = GoRouter(
  // UPDATED: The app will now start at the home screen.
  initialLocation: '/home',
  routes: <RouteBase>[
    // This route is no longer the initial route but can be used for other auth-related logic.
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const AuthGate(),
    ),

    // Home Screen route
    GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) => const HomeScreen()
    ),

    // Profile route
    GoRoute(
        path: '/profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const ProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0); // Slide from bottom
            const end = Offset.zero;
            const curve = Curves.ease;
            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        )
    ),

    // Registration and Login routes
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) => const RegistrationScreen(),
    ),
    GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) => const LoginScreen()
    ),

    // Onboarding route
    GoRoute(
        path: '/welcome',
        builder: (BuildContext context, GoRouterState state) => const OnboardingScreen()
    )
  ],
);
