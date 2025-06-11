import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chronova_app/config/app_router.dart';
import '../services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController(); // For password confirmation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Verify if the password is the same
  final bool _isSamePassword = false;
  bool _isLoading = false;
  String errorMessage = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future <void> _createAccount() async {
    if (_formKey.currentState!.validate())
    {
      setState(() {
        _isLoading = true;
      });

      try {
        // Registration method from autService
        await authService.value.createAccount(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim()
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(e.message ?? 'Registration Failed. Try Later'),
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
    return Scaffold(
      backgroundColor: const Color(0xFF28264F), // Background color
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
                    color: Colors.white24, // Placeholder color
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(height: 40),

                // Welcome Text
                const Text(
                  "Create Your Chronova Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Email Input
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.white70),
                    hintText: "email",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF3A3861),
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
                  ),
                ),

                const SizedBox(height: 20),

                // Confirm Password Input
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                    hintText: "Confirm Password",
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF3A3861),
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
                      style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 30),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator(),)
                      : FilledButton(
                    onPressed: _createAccount,

                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(
                        color: Colors.white,
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
                    appRouter.go('/login'); // Navigate back to the login screen
                  },
                  child: const Text(
                    "Already have an account? Sign In",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),

                const SizedBox(height: 40),

                // OR CONTINUE WITH (Optional - keep for consistency or remove if only email/pass)
                const Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.white38),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "OR CONTINUE WITH",
                        style: TextStyle(color: Colors.white30, fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.white38),
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
                          const SnackBar(content: Text('Google registration coming soon!')),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.mail,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Facebook Button (Placeholder)
                    InkWell(
                      onTap: () {
                        // TODO: Implement Facebook login for registration if desired
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Facebook registration coming soon!')),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(Icons.facebook, color: Colors.white, size: 24),
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