import 'package:espresso/models/expresso.dart';
import 'package:flutter/material.dart';


class ExpressoTile extends StatelessWidget {

  final Expresso expresso;

  ExpressoTile({this.expresso});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20,6,20,0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.green[expresso.strength],
            backgroundImage: AssetImage('assets/13.png'),
            
          ),
          title: Text(expresso.name),
          subtitle: Text('Takes ${expresso.sugars} sugar(s)'),
        ),
      ),
    );
  }
}