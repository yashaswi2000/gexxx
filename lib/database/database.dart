import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gexxx_flutter/models/user.dart';

class DatabaseService{
  final String uid;

 
   DatabaseService({this.uid});

  final CollectionReference UsersCollection =  Firestore.instance.collection('Users');

 

  Future UpdateUsersCollection(String name,String email)async
  {
    return await UsersCollection.document(uid).setData({
      'name':name,
      'émail':email
    });
  }
   UserData  _userDataFromSnapShot(DocumentSnapshot snapshot)
  {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
    );
  }

  //collection stream
  Stream<UserData> get userData{
    return UsersCollection.document(uid).snapshots().map(_userDataFromSnapShot);

  }

 


}