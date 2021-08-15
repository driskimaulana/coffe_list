import 'package:flutter/material.dart';
import 'package:ninja_brew/screens/authenticate/register.dart';
import 'package:ninja_brew/screens/authenticate/signIn.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  /// creating function to toggle the sign menu
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? Container(
            child: SignIn(
            toggleView: toggleView,
          ))
        : Container(
            child: Register(
            toggleView: toggleView,
          ));
  }
}
