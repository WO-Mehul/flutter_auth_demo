import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_auth_demo/services/auth.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Screen"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                'Signup Information',
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
                  child: Text("SIGNUP"),
                  onPressed: () async {
                    // save the fields..
                    final form = _formKey.currentState;
                    form.save();

                    // Validate will return true if is valid, or false if invalid.
                    try {
                      if (form.validate()) {
                        await Provider.of<AuthService>(context, listen: false)
                            .signUp(email: _email, password: _password);
                      }
                    } catch (e) {
                      print(e.message);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}