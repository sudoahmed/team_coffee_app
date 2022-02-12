import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_coffee/models/user.dart';
import 'package:team_coffee/services/database.dart';
import 'package:team_coffee/shared/constants.dart';
import 'package:team_coffee/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName, _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: kDefaultInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please Enter a name' : null,
                    onChanged: (val) => setState(() {
                      _currentName = val;
                    }),
                  ),
                  //Dropdown

                  DropdownButtonFormField(
                    value: _currentSugars ?? userData.sugars,
                    hint: Text('Select number of sugars'),
                    // TODO : COntinue here tutorial no. 22
                    items: sugars
                        .map<DropdownMenuItem>(
                          (sugar) => DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars'),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _currentSugars = val.toString();
                      });
                    },
                  ),
                  //Slider
                  Slider(
                      //TODO: User Data and stream tutorial #24
                      activeColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      inactiveColor:
                          Colors.brown[_currentStrength ?? userData.strength],
                      value: (_currentStrength ?? 100).toDouble(),
                      min: 100,
                      max: 900,
                      divisions: 8,
                      onChanged: (val) => setState(() {
                            _currentStrength = val.round();
                          })),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pink)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            print(snapshot);

            return Loading();
          }
        });
  }
}
