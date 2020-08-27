import 'package:firebase_auth/firebase_auth.dart' as authPack;
import 'package:flutter_auth_demo/models/user.dart';

class AuthService {
  final authPack.FirebaseAuth _auth = authPack.FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(authPack.User user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth
        .authStateChanges()
        //.map((authPack.User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    print('email $email');
    print('password $password');
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      authPack.User user = result.user;
      // create a new document for the user with the uid
      // await DatabaseService(uid: user.uid)
      //     .updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
      authPack.User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
