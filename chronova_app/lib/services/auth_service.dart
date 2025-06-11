// File: lib/services/auth_gate.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import google_sign_in
import 'package:firebase_database/firebase_database.dart'; // Import firebase_database

// ValueNotifier is a class that notifies its listeners when the value changes
ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); // GoogleSignIn instance
  final DatabaseReference _database = FirebaseDatabase.instance.ref(); // Firebase Realtime Database instance

  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signIn ({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password);
  }

  // Create a new user with email and password
  Future<UserCredential?> createAccount ({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password);
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Abort if the user cancelled the sign-in
      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);

      // Store user data in Realtime Database if it's a new user or on subsequent logins
      if (userCredential.user != null) {
        await _storeUserData(userCredential.user!);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Auth specific errors
      debugPrint("Firebase Auth Error: ${e.code} - ${e.message}");
      rethrow; // Rethrow to be caught by UI
    } catch (e) {
      // Handle other potential errors (e.g., network issues)
      debugPrint("Error signing in with Google: $e");
      rethrow; // Rethrow to be caught by UI
    }
  }

  // Store user's name and email in the Realtime Database
  Future<void> _storeUserData(User user) async {
    final userRef = _database.child('users/${user.uid}');
    // Use .set() to completely overwrite or create the data
    // Use .update() if you only want to update specific fields without overwriting others
    await userRef.set({
      'email': user.email,
      'displayName': user.displayName,
      'lastSignInTime': DateTime.now().toIso8601String(),
    });
    debugPrint("User data stored/updated for UID: ${user.uid}");
  }


  // Sign out the current user
  Future<void> signOut() async {
    await _googleSignIn.signOut(); // Sign out from Google
    await firebaseAuth.signOut(); // Sign out from Firebase
  }

  // Reset password
  Future<void> resetPassword({
    required String email,
  }) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Update username
  Future<void> updateUsername({
    required String username,
  }) async {
    await currentUser!.updateDisplayName(username);
  }
  // Delete account
  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }

  // Reset password from current password
  Future<void> resetPasswordFromCurrentPassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }
}