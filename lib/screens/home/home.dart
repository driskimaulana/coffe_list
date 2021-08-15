import 'package:flutter/material.dart';
import 'package:ninja_brew/models/brew.dart';
import 'package:ninja_brew/screens/home/brew_list.dart';
import 'package:ninja_brew/screens/home/setting_form.dart';
import 'package:ninja_brew/services/auth.dart';
import 'package:ninja_brew/services/database.dart';
import 'package:ninja_brew/shared/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _currentName;
    String _currentSugars;
    int _currentStrength;
    final AuthService _auth = AuthService();

    final _formkey = GlobalKey<FormState>();

    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingForm();
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.brown[600],
          title: Text('Brew Crew'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            FlatButton.icon(
                onPressed: () => _showSettingPanel(),
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: Text('setting',
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
