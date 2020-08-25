import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_demo/screens/signup.dart';
import 'package:provider/provider.dart';

import 'package:flutter_auth_demo/screens/home.dart';
import 'package:flutter_auth_demo/screens/login.dart';
import 'package:flutter_auth_demo/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<AuthService>(
      create: (_) => AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyApp(),
        routes: <String, WidgetBuilder>{
          // Set routes for using the Navigator.
          '/signup': (BuildContext context) => new SignupScreen(),
          '/home': (BuildContext context) => new HomeScreen(),
        },
      )));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return StreamBuilder<User>(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return LoginScreen();
          }
          return HomeScreen();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
