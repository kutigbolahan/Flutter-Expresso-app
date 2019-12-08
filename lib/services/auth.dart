import 'package:espresso/models/user.dart';
import 'package:espresso/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of firebase auth create obj to communicate with backend
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firbase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change stream //it returns when there is change in authentication
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in anon //asynchronous task that returns future
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign in with email and password
   Future signInWithEmailAndPassword(String email, String password)async{
    try {
      AuthResult result= await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //register with email and password
  Future registerWithEmailAndPassword(String email, String password)async{
    try {
      AuthResult result= await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
    //create a new document for a user with the uid
    await DatabaseService(uid: user.uid).updateUserData('0', 'new member', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //sign out
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
