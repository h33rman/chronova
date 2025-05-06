import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// Screens Home
import 'package:chronova_app/screens/home_screen.dart';
import 'package:chronova_app/screens/login_screen.dart';
import 'package:chronova_app/screens/news_screen.dart';
import 'package:chronova_app/screens/notification_screen.dart';
import 'package:chronova_app/screens/ranking_screen.dart';

import '../screens/offline/offline_setup.dart';
import '../screens/online/offline_setup.dart';


Future <bool> isUserLoggedIn() async {
  // Simulate a network call to check if the user is logged in
  await Future.delayed(const Duration(milliseconds: 500));
  return false; // Change this to true if the user is logged in
}


// GoRouter configuration
final GoRouter appRouter = GoRouter(
  initialLocation: '/', // Start at the root home

  redirect: (context, state) async {
    final loggedIn = await isUserLoggedIn();
    final goingToLogin = state.matchedLocation == '/login';

    // If not logged in and not going to the login page, redirect to login
    if (!loggedIn && !goingToLogin) {
      return '/login';
    }

    // If logged in and going to the login page, redirect to home
    if (loggedIn && goingToLogin) {
      return '/';
    }

    // No redirect needed
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/offline',
      builder: (BuildContext context, GoRouterState state) => const OfflineSetup(),
    ),
    GoRoute(
      path: '/online',
      builder: (BuildContext context, GoRouterState state) => const OnlineSetup(),
    ),
    GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) => const LoginScreen()
    )
  ],
);