import 'dart:core';

import 'package:flutter/material.dart';
import 'package:ninja_brew/models/user.dart';
import 'package:ninja_brew/services/database.dart';
import 'package:ninja_brew/shared/constants.dart';
import 'package:ninja_brew/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  // get the uid from UserData strem
  final _formkey = GlobalKey<FormState>();
  // creting list for dropdown sugar menu
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 60.0,
      ),
      child: StreamBuilder<DocData?>(
          stream: DatabaseService(uid: user!.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DocData? userData = snapshot.data;
              return Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Update Your Brew Preferennce',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      initialValue: _currentName ?? userData?.name,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your name' : null,
                      decoration:
                          inputTextDecoration.copyWith(hintText: 'Name'),
                      onChanged: (val) => setState(() {
                        _currentName = val;
                      }),
                    ),
                    // dropdown
                    DropdownButtonFormField(
                      decoration: inputTextDecoration,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          child: Text('${sugar} sugars'),
                          value: sugar,
                        );
                      }).toList(),
                      onChanged: (val) => setState(() {
                        _currentSugars = val as String?;
                      }),
                      value: _currentSugars ?? userData!.sugars,
                    ),
                    // slider
                    Slider(
                      activeColor:
                          Colors.brown[_currentStrength ?? userData!.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData!.strength],
                      value:
                          (_currentStrength ?? userData!.strength).toDouble(),
                      min: 100.0,
                      max: 900,
                      divisions: 8,
                      onChanged: (val) =>
                          setState(() => _currentStrength = val.round()),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).UpdateUserData(
                              _currentSugars ?? userData!.sugars,
                              _currentName ?? userData!.name,
                              _currentStrength ?? userData!.strength);
                          Navigator.pop(context);
                        }
                      },
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
  }
}
