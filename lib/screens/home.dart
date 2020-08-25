import 'package:flutter/material.dart';
import 'package:flutter_auth_demo/services/auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
     floatingActionButton: FloatingActionButton.extended(
        label: Text('Sign out'),
        onPressed: () async {
          final auth = Provider.of<AuthService>(context, listen: false);
          await auth.signOut();
        },
      ),
    );
  }
}
