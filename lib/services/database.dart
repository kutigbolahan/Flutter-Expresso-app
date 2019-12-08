import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espresso/models/expresso.dart';
import 'package:espresso/models/user.dart';

class DatabaseService{
  //declare a property for the uid
  final String uid;

  DatabaseService({this.uid});
  //collecting reference
  final CollectionReference expressoCollection = Firestore.instance.collection('expressos');

  Future updateUserData(String sugars, String name, int strength)async{
    return await expressoCollection.document(uid).setData({
       'sugars' : sugars,
       'name' : name,
       'strength' : strength,
    });
  }
  //expressolist fron snapshot
  List<Expresso> _expressoListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
       return Expresso(
         name: doc.data['name'] ?? '',
         strength: doc.data['strength'] ?? 0,
         sugars: doc.data['sugars'] ?? '0'
       );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }
  //get expresso streams
  Stream<List<Expresso>>get expressos{
    return expressoCollection.snapshots()
    .map( _expressoListFromSnapshot);
  }


  //get user doc stream
  Stream<UserData> get userData {
    return expressoCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}