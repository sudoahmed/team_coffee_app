import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_coffee/models/brew.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({Key? key, required this.brew}) : super(key: key);

  final Brew brew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugar} sugar(s)'),
        ),
      ),
    );
  }
}