import 'package:espresso/services/auth.dart';
import 'package:espresso/shared/constants.dart';
import 'package:espresso/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //instance of the authservice class
  final AuthService _auth = AuthService();
   final _formKey = GlobalKey<FormState>();
   //for the spinning widget
   bool loading = false;

   
  

  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        title: Text('Sign in to Expresso'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white),
            label: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email': null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                 decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long': null,
                
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.blueGrey,
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                 if (_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Could not sign in with those credentials';
                        loading = false;
                      }
                      );
                    } 
                  } 
                },
              ),
               SizedBox(height: 12,),
              Text(error,
              style: TextStyle(color: Colors.red, fontSize: 14),
              )
            ],
          ),
        ),

        //RaisedButton(
        //   child: Text('Sign in anon'),
        //   onPressed: () async {
        //     //we store the _auth.signInAnon method in the result variable
        //   dynamic result = await  _auth.signInAnon();
        //   if (result == null) {
        //     print('error signing in');
        //   }else{
        //     print('signed in');
        //     print(result.uid);
        //   }
        //   },
        // ),
      ),
    );
  }
}
