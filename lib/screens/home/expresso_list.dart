import 'package:espresso/models/expresso.dart';
import 'package:espresso/screens/home/expresso_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpressoList extends StatefulWidget {
  @override
  _ExpressoListState createState() => _ExpressoListState();
}

class _ExpressoListState extends State<ExpressoList> {
  @override
  Widget build(BuildContext context) {
    final expressos = Provider.of<List<Expresso>>(context) ?? [];

    return ListView.builder(
      itemCount: expressos.length,
      itemBuilder: (context, index) {
        return ExpressoTile(expresso: expressos[index]);
      },
    );
  }
}
