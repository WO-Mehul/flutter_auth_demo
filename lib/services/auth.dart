import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

   // Sign up async functions here
  Future<void> signUp(
      {@required String email, @required String password}) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  // Sign in async functions here
  Future<void> signIn(
      {@required String email, @required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  // Sign out async functions here
  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  // create a getter stream for get auth state change
  Stream<User> get authStateChanges => _auth.authStateChanges();
}
