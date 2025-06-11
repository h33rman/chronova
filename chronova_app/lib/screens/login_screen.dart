// File: lib/screens/online/login_screen.dart

import 'package:flutter/material.dart';
import 'package:chronova_app/config/app_router.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // NEW: Import to catch specific exceptions

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // NEW: A key to manage the state of the form for validation
  final _formKey = GlobalKey<FormState>();

  // NEW: Controllers to manage the text in the input fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // NEW: State variable to toggle password visibility
  bool _isPasswordObscured = true;

  // NEW: State variable to show a loading indicator
  bool _isLoading = false;

  // NEW: Clean up the controllers when the widget is disposed
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // NEW: Method to handle the "CONNECT" button press
  Future<void> _signInWithEmail() async {
    // First, validate the form inputs
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        // Call the signIn method from our authService
        await authService.value.signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // After successful login, the StreamBuilder in your root widget
        // should handle the navigation. No need for appRouter.go('/') here.

      } on FirebaseAuthException catch (e) {
        // If an error occurs, show a user-friendly message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(e.message ?? 'Login failed. Please try again.'),
          ),
        );
      } finally {
        // Ensure the loading indicator is hidden, even if an error occurs
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  // NEW: Method to handle the Google Sign-In button press
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await authService.value.signInWithGoogle();
      // On success, StreamBuilder will handle navigation
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(e.message ?? 'An unknown error occurred.'),
        ),
      );
    } catch (e) {
      // Handle cases where the user cancels the Google sign-in flow
      debugPrint('Google sign-in cancelled or failed: $e');
    }
    finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28264F),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          // NEW: Wrap the column in a Form widget
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo Placeholder - No changes needed here
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.timer_outlined, color: Colors.white, size: 60), // Example Icon
                ),
                const SizedBox(height: 40),
                const Text(
                  "Welcome to Chronova",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Email Input
                TextFormField(
                  controller: _emailController, // NEW: Connect controller
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.white70),
                    hintText: "Email", // Changed to be more specific
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF3A3861),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  // NEW: Add validation
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
                  controller: _passwordController, // NEW: Connect controller
                  obscureText: _isPasswordObscured, // NEW: Toggle visibility
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF3A3861),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    // NEW: Eye icon to toggle password visibility
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                  ),
                  // NEW: Add validation
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                // Forgot Password - You can expand on this later
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password logic (e.g., show a dialog)
                    },
                    child: const Text(
                      "Forgot password",
                      style: TextStyle(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Connect Button
                SizedBox(
                  width: double.infinity,
                  // NEW: Show a loading indicator or the button
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : FilledButton(
                    onPressed: _signInWithEmail, // NEW: Call our method
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // A little rounded looks nice
                      ),
                    ),
                    child: const Text(
                      "CONNECT",
                      style: TextStyle(
                        color: Colors.white,
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
                      appRouter.push('/register');
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF3A3861),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "CREATE AN ACCOUNT",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // OR CONTINUE WITH
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white38)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "OR CONTINUE WITH",
                        style: TextStyle(color: Colors.white30, fontSize: 12),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white38)),
                  ],
                ),
                const SizedBox(height: 20),

                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google Button
                    InkWell(
                      onTap: _signInWithGoogle, // NEW: Call our Google sign-in method
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Colors.white12,
                          shape: BoxShape.circle,
                        ),
                        // Using a proper Google icon would be best
                        // For now, mail is a good placeholder
                        child: const Icon(
                          Icons.mail_outline, // Changed for clarity
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    // You can add more social logins here following the same pattern
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