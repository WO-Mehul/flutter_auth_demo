import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_auth_demo/screens/home.dart';
import 'package:flutter_auth_demo/screens/login.dart';
import 'package:flutter_auth_demo/services/auth.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<AuthService>(
      child: MyApp(),
      builder: (BuildContext context) {
        return AuthService();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          // get the Provider, and call the getUser method
          future: Provider.of<AuthService>(context).getUser(),
          // wait for the future to resolve and render the appropriate
          // widget for HomePage or LoginPage
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.hasData ? HomeScreen() : LoginScreen();
            } else {
              return Container(color: Colors.white);
            }
          },
        ));
  }
}
