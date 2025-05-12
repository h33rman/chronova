import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// Screens Home
import 'package:chronova_app/screens/home_screen.dart';
import 'package:chronova_app/screens/login_screen.dart';
import 'package:chronova_app/screens/news_screen.dart';
import 'package:chronova_app/screens/notification_screen.dart';
import 'package:chronova_app/screens/ranking_screen.dart';

import '../screens/offline/offline_setup.dart';
import '../screens/online/online_setup.dart';
import '../widgets/home_bar.dart';


// GoRouter configuration
final GoRouter appRouter = GoRouter(
  initialLocation: '/login', // Set login as the default landing page
  routes: <RouteBase>[
    GoRoute(
      path: '/', // Navigation between screen
      builder: (BuildContext context, GoRouterState state) => const BottomBarMenu(),
    ),
    GoRoute(
      path: '/online',
      builder: (BuildContext context, GoRouterState state) => const OnlineSetupScreen(),
    ),
    GoRoute(
      path: '/offline',
      builder: (BuildContext context, GoRouterState state) => const OfflineSetupScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
    ),
  ],
);