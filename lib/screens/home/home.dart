import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_demo/services/auth.dart';

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Profile', icon: Icons.account_circle),
  const Choice(title: 'Logout', icon: Icons.exit_to_app),
];

// This app is a stateful, it tracks the user's current choice.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  void _select(Choice choice) async {
    switch (choice.title) {
      case 'Logout':      
         await _auth.signOut();
        break;
      case 'Profile':
        // do something else
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello Home'),
          backgroundColor: Colors.blue,
          elevation: 0.0,
          actions: <Widget>[        
            // overflow menu
            PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(choice.icon, color: Colors.blue),
                          SizedBox(width: 10),
                          Text(choice.title)
                        ],
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ));
  }
}
