import 'package:flutter/material.dart';
import 'package:flutter_auth_demo/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Hello'),
      backgroundColor: Colors.blue,
      elevation: 0.0,
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('logout'),
          onPressed: () async {
            await _auth.signOut();
          },
        )
      ],
    ));
    // return Center(
    //   child: RaisedButton(
    //     highlightElevation: 0.0,
    //     highlightColor: Colors.blueAccent,
    //     elevation: 4.0,
    //     color: Colors.lightBlueAccent,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: new BorderRadius.circular(30.0)),
    //     child: Text(
    //       'Logout',
    //       style: TextStyle(
    //           fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
    //     ),
    //     onPressed: () async {
    //        await _auth.signOut();
    //     },
    //   ),
    // );
  }
}
