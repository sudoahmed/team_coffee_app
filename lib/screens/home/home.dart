import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:team_coffee/models/brew.dart';
import 'package:team_coffee/screens/home/setting_forms.dart';
import 'package:team_coffee/services/auth.dart';
import 'package:team_coffee/services/database.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    final AuthService _auth = AuthService();

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Team Coffee'),
          backgroundColor: Colors.brown[400],
          actions: [
            ElevatedButton.icon(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0.0),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.brown[400])),
              onPressed: () {
                _auth.signOut();
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
            ),
            ElevatedButton.icon(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0.0),
                  backgroundColor: MaterialStateProperty.all(Colors.brown[400]),
                ),
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text('Settings'))
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/coffee_bg.png',
              ),
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
