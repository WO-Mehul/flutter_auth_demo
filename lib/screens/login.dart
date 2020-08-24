import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_auth_demo/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'Login Information',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  onSaved: (String value) => _email = value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email Address")),
              TextFormField(
                  onSaved: (String value) => _password = value,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password")),
              SizedBox(height: 20.0),
              RaisedButton(
                  child: Text("LOGIN"),
                  onPressed: () async {
                    // save the fields..
                    final form = _formKey.currentState;
                    form.save();

                    // Validate will return true if is valid, or false if invalid.
                    if (form.validate()) {
                      var result = await Provider.of<AuthService>(context)
                          .loginUser(email: _email, password: _password);
                          print(result);
                      if (result == null) {
                        // see project in github for this code
                        //return _buildShowErrorDialog(context,
                        //    "Error Logging In With Those Credentials");
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class _email {}
