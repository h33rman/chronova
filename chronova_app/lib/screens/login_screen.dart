// File: lib/screens/online/login_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Using go_router for navigation
import 'package:chronova_app/config/app_router.dart';
import 'package:chronova_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import to catch specific exceptions

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        await authService.value.signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        appRouter.go('/home'); // Navigate to the home screen after successful login
        // On successful login, the StreamBuilder in your AuthGate will handle navigation.
        // No explicit appRouter.go('/') call needed here.
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error, // Use theme error color
            content: Text(e.message ?? 'Login failed. Please try again.',
              style: TextStyle(color: Theme.of(context).colorScheme.onError), // Use theme onError color
            ),
          ),
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

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await authService.value.signInWithGoogle();
      // On success, StreamBuilder in AuthGate will handle navigation
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error, // Use theme error color
          content: Text(e.message ?? 'An unknown error occurred.',
            style: TextStyle(color: Theme.of(context).colorScheme.onError), // Use theme onError color
          ),
        ),
      );
    } catch (e) {
      debugPrint('Google sign-in cancelled or failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error, // Use theme error color
          content: Text('Google sign-in failed or cancelled.',
            style: TextStyle(color: Theme.of(context).colorScheme.onError), // Use theme onError color
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the ColorScheme from the current theme
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface, // Use theme background color
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
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4), // Use a theme color with opacity
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.timer_outlined,
                    color: colorScheme.onSurface, // Use theme onSurface color
                    size: 60,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "Welcome to Chronova",
                  style: TextStyle(
                    color: colorScheme.onSurface, // Use theme onBackground color
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Email Input
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: colorScheme.onSurface), // Use theme onSurface color
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline, color: colorScheme.onSurfaceVariant), // Use theme onSurfaceVariant
                    hintText: "Email",
                    hintStyle: TextStyle(color: colorScheme.onSurfaceVariant), // Use theme onSurfaceVariant
                    filled: true,
                    fillColor: colorScheme.surfaceContainer, // Use theme surface color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Input
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isPasswordObscured,
                  style: TextStyle(color: colorScheme.onSurface), // Use theme onSurface color
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline, color: colorScheme.onSurfaceVariant), // Use theme onSurfaceVariant
                    hintText: "Password",
                    hintStyle: TextStyle(color: colorScheme.onSurfaceVariant), // Use theme onSurfaceVariant
                    filled: true,
                    fillColor: colorScheme.surfaceContainer, // Use theme surface color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                        color: colorScheme.onSurfaceVariant, // Use theme onSurfaceVariant
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password logic (e.g., show a dialog)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Forgot Password functionality coming soon!',
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                          backgroundColor: colorScheme.surfaceContainerHighest,
                        ),
                      );
                    },
                    child: Text(
                      "Forgot password",
                      style: TextStyle(color: colorScheme.primary), // Use theme primary color
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Connect Button
                SizedBox(
                  width: double.infinity,
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator(color: colorScheme.onSurface)) // Use theme color
                      : FilledButton(
                    onPressed: _signInWithEmail,
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.primary, // Use theme primary color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: colorScheme.onPrimary, // Text color on primary button
                    ),
                    child: const Text(
                      "CONNECT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Create an Account Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      context.push('/register'); // Use context.push for navigation
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.surface, // Use theme surface color for secondary button
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      foregroundColor: colorScheme.onSurface, // Text color on surface button
                    ),
                    child: const Text(
                      "CREATE AN ACCOUNT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // OR CONTINUE WITH
                Row(
                  children: [
                    Expanded(child: Divider(color: colorScheme.outline)), // Use theme outline color
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "OR CONTINUE WITH",
                        style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5), fontSize: 12), // Adjusted opacity
                      ),
                    ),
                    Expanded(child: Divider(color: colorScheme.outline)), // Use theme outline color
                  ],
                ),
                const SizedBox(height: 20),

                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Button
                    InkWell(
                      onTap: _signInWithGoogle,
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3), // Use theme surfaceVariant with opacity
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.mail_outline,
                          color: colorScheme.onSurface, // Use theme onSurface color
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20), // Added spacing between social buttons
                    // Facebook Button (Placeholder for consistency)
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Facebook login coming soon!',
                              style: TextStyle(color: colorScheme.onSurface),
                            ),
                            backgroundColor: colorScheme.surfaceContainerHighest,
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3), // Use theme surfaceVariant with opacity
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.facebook,
                          color: colorScheme.onSurface, // Use theme onSurface color
                          size: 24,
                        ),
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