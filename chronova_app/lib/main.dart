// File: main.dart

import 'package:chronova_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:chronova_app/config/app_router.dart';
// import 'widgets/home_bar.dart'; // No longer needed directly in main.dart
import 'package:chronova_app/config/app_color_schemes.dart'; // Import your color schemes
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Not directly used here
import 'package:provider/provider.dart'; // NEW: Import provider
import 'package:chronova_app/providers/theme_provider.dart'; // NEW: Import your ThemeProvider

Future <void> main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    // NEW: Wrap your app with ChangeNotifierProvider for ThemeProvider
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // NEW: Access the ThemeProvider
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Chronova',
      // NEW: Define your light theme
      theme: ThemeData(
        colorScheme: MaterialTheme.lightScheme(),
        useMaterial3: true,
        // You can add other properties specific to the light theme here
        // For example, if you want different AppBar colors than what colorScheme provides
        // appBarTheme: const AppBarTheme(
        //   backgroundColor: Colors.white,
        //   foregroundColor: Colors.black,
        // ),
      ),
      // NEW: Define your dark theme
      darkTheme: ThemeData(
        colorScheme: MaterialTheme.darkScheme(),
        useMaterial3: true,
        // You can add other properties specific to the dark theme here
      ),
      // NEW: Control the theme mode using the ThemeProvider
      themeMode: themeProvider.themeMode,
    );
  }
}