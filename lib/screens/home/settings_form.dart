import 'package:espresso/models/user.dart';
import 'package:espresso/services/database.dart';
import 'package:espresso/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:espresso/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Your Expresso Settings',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  //slider
                  Slider(
                    activeColor:
                        Colors.green[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.green[_currentStrength ?? userData.strength],
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid)
                            .updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength
                            );
                            Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
