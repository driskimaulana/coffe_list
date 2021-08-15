import 'package:flutter/material.dart';
import 'package:ninja_brew/services/auth.dart';
import 'package:ninja_brew/shared/constants.dart';
import 'package:ninja_brew/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String _email = '';
  String _password = '';
  String _errorMessage = '';
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              title: Text('Sign Up to Brew Crew'),
              backgroundColor: Colors.brown[600],
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            inputTextDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val!.isNotEmpty
                            ? null
                            : "Please Enter Email Addres",
                        onChanged: (val) {
                          setState(
                            () {
                              _email = val;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            inputTextDecoration.copyWith(hintText: 'Password'),
                        validator: (val) =>
                            val!.length < 6 ? 'Enter More than 6 Char' : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(
                            () {
                              _password = val;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          if (_formkey.currentState!.validate()) {
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    _email, _password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                _errorMessage = "Invalid Email";
                              });
                            }
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.pink[400],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
