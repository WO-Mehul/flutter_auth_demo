import 'package:flutter/material.dart';
import 'package:flutter_auth_demo/services/auth.dart';
import 'package:flutter_auth_demo/shared/constants.dart';
import 'package:flutter_auth_demo/shared/loader.dart';

final AuthService _auth = AuthService();

Widget _buildSocialBtn(Function onTap, AssetImage logo) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
        image: DecorationImage(
          image: logo,
        ),
      ),
    ),
  );
}

Widget _buildSocialBtnRow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildSocialBtn(
          () => _auth.signInWithFacebook(),
          AssetImage(
            'assets/logos/facebook.jpg',
          ),
        ),
        _buildSocialBtn(
          () => print('Login with Google'),
          AssetImage(
            'assets/logos/google.jpg',
          ),
        ),
      ],
    ),
  );
}

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loader()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).primaryColor,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                    child: Text('Hello',
                                        style: TextStyle(
                                            fontSize: 80.0,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Email'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Password'),
                              obscureText: true,
                              validator: (val) =>
                                  val.isEmpty ? 'Enter a paasword' : null,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              child: RaisedButton(
                                highlightElevation: 0.0,
                                highlightColor: Colors.blueAccent,
                                elevation: 4.0,
                                color: Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'Please supply a valid email';
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text('- OR -'),
                            SizedBox(height: 20.0),
                            Text('Sign in with',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            _buildSocialBtnRow(),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(width: 5.0),
                                InkWell(
                                  onTap: () => widget.toggleView(),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ))),
            ));
  }
}
