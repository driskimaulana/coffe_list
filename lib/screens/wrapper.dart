import 'package:flutter/material.dart';
import 'package:ninja_brew/models/user.dart';
import 'package:ninja_brew/screens/authenticate/authenticate.dart';
import 'package:ninja_brew/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);

    return user != null ? Home() : Authenticate();
  }
}
