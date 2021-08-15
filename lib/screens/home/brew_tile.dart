import 'package:flutter/material.dart';
import 'package:ninja_brew/models/brew.dart';

class BrewTile extends StatelessWidget {
  // creating instance of brew class
  final Brew brew;
  // constructor to receive brew data
  BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 8, 10, 0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.brown[brew.strength],
            radius: 25.0,
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar[s].'),
        ),
      ),
    );
  }
}
