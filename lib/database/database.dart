import 'package:cloud_firestore/cloud_firestore.dart';

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

  //collection stream
  Stream<QuerySnapshot> get userstream{
    return UsersCollection.snapshots();

  }


}