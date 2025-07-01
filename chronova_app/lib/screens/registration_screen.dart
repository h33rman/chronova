// File: lib/screens/registration_screen.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chronova_app/config/app_router.dart'; // Ensure this is imported for appRouter variable
import '../services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String errorMessage = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future <void> _createAccountAndNavigate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        errorMessage = ""; // Clear previous errors
      });

      try {
        UserCredential? userCredential = await authService.value.createAccount(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (userCredential != null && mounted) {
          // --- CHANGED: Using appRouter.go() for explicit navigation ---
          appRouter.go('/welcome'); // Navigate to WelcomeScreen using appRouter
          /*
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Account created successfully!'),
              backgroundColor: Theme.of(context).colorScheme.primary, // Use theme primary for success
              behavior: SnackBarBehavior.floating, // Make it floating for better visibility
            ),
          );
          */
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message ?? 'An unknown error occurred during registration.';
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error, // Use theme error color
              content: Text(e.message ?? 'Registration Failed. Please try again.',
                style: TextStyle(color: Theme.of(context).colorScheme.onError), // Use theme onError
              ),
              behavior: SnackBarBehavior.floating, // Make it floating
            )
        );
      } catch (e) {
        setState(() {
          errorMessage = "An unexpected error occurred: ${e.toString()}";
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.error, // Use theme error color
              content: Text("An unexpected error occurred: ${e.toString()}",
                style: TextStyle(color: Theme.of(context).colorScheme.onError), // Use theme onError
              ),
              behavior: SnackBarBehavior.floating, // Make it floating
            )
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo Placeholder
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4), // Use theme color with opacity
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.timer_outlined,
                    color: colorScheme.onSurface,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 40),

                // Welcome Text
                Text(
                  "Create Your Chronova Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Email Input
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: colorScheme.onSurface),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline, color: colorScheme.onSurfaceVariant),
                    hintText: "email",
                    hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                    filled: true,
                    fillColor: colorScheme.surfaceContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Input
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: TextStyle(color: colorScheme.onSurface),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline, color: colorScheme.onSurfaceVariant),
                    hintText: "Password",
                    hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                    filled: true,
                    fillColor: colorScheme.surfaceContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password.';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Confirm Password Input
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: TextStyle(color: colorScheme.onSurface),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline, color: colorScheme.onSurfaceVariant),
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                    filled: true,
                    fillColor: colorScheme.surfaceContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password.';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Display Error Message
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: colorScheme.error, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 30),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator(color: colorScheme.onSurface))
                      : FilledButton(
                    onPressed: _createAccountAndNavigate,
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: colorScheme.onPrimary,
                    ),
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Back to Login Button
                TextButton(
                  onPressed: () {
                    // --- CHANGED: Using appRouter.go() for explicit navigation ---
                    appRouter.go('/login'); // Navigate to login using appRouter
                  },
                  child: Text(
                    "Already have an account? Sign In",
                    style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.7)),
                  ),
                ),

                const SizedBox(height: 40),

                // OR CONTINUE WITH (Optional - keep for consistency or remove if only email/pass)
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: colorScheme.outline),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "OR CONTINUE WITH",
                        style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5)),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: colorScheme.outline),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Social Login Buttons (Optional - keep for consistency or remove if only email/pass)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Button (Placeholder)
                    InkWell(
                      onTap: () {
                        // TODO: Implement Google login for registration if desired
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Google registration coming soon!',
                              style: TextStyle(color: colorScheme.onSurface),
                            ),
                            backgroundColor: colorScheme.surfaceContainerHighest,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.mail_outline, color: colorScheme.onSurface, size: 24),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Facebook Button (Placeholder)
                    InkWell(
                      onTap: () {
                        // TODO: Implement Facebook login for registration if desired
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Facebook registration coming soon!',
                              style: TextStyle(color: colorScheme.onSurface),
                            ),
                            backgroundColor: colorScheme.surfaceContainerHighest,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.facebook, color: colorScheme.onSurface, size: 24),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}