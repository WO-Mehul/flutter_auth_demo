import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_demo/models/user.dart';
import 'package:flutter_auth_demo/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auth_demo/services/auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.l̥
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      stream: AuthService().user,
      child: MaterialApp(home: Wrapper()),
    );
  }
}
