// File: lib/services/auth_gate.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chronova_app/services/auth_service.dart';
import 'package:chronova_app/screens/login_screen.dart';
import 'package:chronova_app/screens/home_screen.dart'; // UPDATED: Import HomeScreen

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // This listens to the authentication state from your AuthService
      stream: authService.value.authStateChanges,
      builder: (context, snapshot) {
        // While the app checks for a logged-in user, show a loading circle
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // If the snapshot has user data, they are logged in!
        if (snapshot.hasData) {
          // UPDATED: Show the HomeScreen directly
          return const HomeScreen();
        }

        // Otherwise, the user is not logged in
        else {
          // So, show the login screen
          return const LoginScreen();
        }
      },
    );
  }
}
