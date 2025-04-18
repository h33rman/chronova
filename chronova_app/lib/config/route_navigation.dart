import 'package:chronova_app/screens/home_screen.dart';
import 'package:chronova_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/game_choice',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);

