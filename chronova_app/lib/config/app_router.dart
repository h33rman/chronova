// File: lib/config/app_router.dart

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:chronova_app/services//auth_gate.dart'; // NEW: Import the AuthGate
import 'package:chronova_app/widgets/home_bar.dart';

// Import your other screens
import 'package:chronova_app/screens/registration_screen.dart';
import '../screens/login_screen.dart';
import '../screens/offline/offline_setup.dart';
import '../screens/online/online_lobby.dart';
import '../screens/online/online_setup.dart';
import '../screens/online/on_game.dart';

// GoRouter configuration
final GoRouter appRouter = GoRouter(
  initialLocation: '/', // NEW: Start at the root, AuthGate will handle the rest
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      // The builder now points to AuthGate.
      // AuthGate will decide to show LoginScreen or BottomBarMenu.
      builder: (BuildContext context, GoRouterState state) => const AuthGate(),
    ),
    GoRoute(
      // This is the route for your main app content with the bottom bar.
      // We keep it separate so we can navigate to it from AuthGate.
      path: '/home',
      builder: (BuildContext context, GoRouterState state) => const BottomBarMenu(),
    ),
    GoRoute(
      path: '/online',
      builder: (BuildContext context, GoRouterState state) => const OnlineSetupScreen(),
    ),
    GoRoute(
        path: "/online_lobby",
        builder: (BuildContext context, GoRouterState state) => const LobbyScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'on_game', // Route paths should not start with '/'
            builder: (BuildContext a, GoRouterState s) => const GamingScreen(),
          )
        ]),
    GoRoute(
      path: '/offline',
      builder: (BuildContext context, GoRouterState state) => const OfflineSetupScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) => const RegistrationScreen(),
    ),
    GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) => const LoginScreen()
    ),
  ],
);