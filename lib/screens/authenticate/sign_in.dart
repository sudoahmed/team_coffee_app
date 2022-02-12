import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_coffee/screens/authenticate/register_user.dart';
import 'package:team_coffee/services/auth.dart';
import 'package:team_coffee/shared/constants.dart';
import 'package:team_coffee/shared/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  final Function() toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String email = '', password = '', error = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text("Sign In to Team Coffee"),
              backgroundColor: Colors.brown[400],
              actions: [
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.brown[400]),
                        elevation: MaterialStateProperty.all(0.0)),
                    onPressed: widget.toggleView,
                    icon: Icon(Icons.app_registration),
                    label: Text("Register"))
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: kDefaultInputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: kDefaultInputDecoration.copyWith(
                        hintText: 'Password',
                      ),
                      validator: (val) => val!.length < 6
                          ? 'Enter a password of 6+ characters'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.pink),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          var result =
                              await _auth.signInWithEmailPass(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Could not sign in with these credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text('Sign In'),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

/*
Container(
padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
child: ElevatedButton(
onPressed: () async {
dynamic result = await _auth.signInAnon();
if (result == null) {
print('Error Signing In');
} else {
print('Sign In');
print(result.uid);
}
},
child: Text('Sign In anon'),
),
),*/
