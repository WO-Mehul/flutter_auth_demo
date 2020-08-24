import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser;

  AuthService() {
    print("New auth service");
  }

  Future getUser() {
    return Future.value(currentUser);
  }

  // warpping the firebase call
  Future logout() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  // wrapping the firebase calls
  Future createUser(
      {String firstName,
      String lastName,
      String email,
      String password}) async {}

  // logs in the user if password matches
  Future loginUser({String email, String password}) {
    if (password == '123') {
      this.currentUser = {'email': email};
      notifyListeners();
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }
  }
}
