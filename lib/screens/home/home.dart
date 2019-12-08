import 'package:espresso/models/expresso.dart';
import 'package:espresso/screens/home/expresso_list.dart';
import 'package:espresso/screens/home/settings_form.dart';
import 'package:espresso/services/auth.dart';
import 'package:espresso/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              //color: Colors.blueGrey,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Expresso>>.value(
      value: DatabaseService().expressos,
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text('Expresso Cofee'),
          backgroundColor: Colors.green[400],
          elevation: 0,
          // leading: Icon(
          //   Icons.local_drink,
          //   color: Colors.white,
          // ),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _showSettingsPanel()),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/4.jpg',
                    ),
                    fit: BoxFit.cover)),
            child: ExpressoList()),
      ),
    );
  }
}
