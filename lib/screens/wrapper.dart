import 'package:espresso/models/user.dart';
import 'package:espresso/screens/authenticate/authenticate.dart';
import 'package:espresso/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    //return home or authemticate widget
   if (user == null) {
     return Authenticate();
   } else {
     return Home();
   }
      
    
  }
}