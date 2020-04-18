//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gexxx_flutter/models/Crop.dart';

import 'package:gexxx_flutter/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference UsersCollection =
      Firestore.instance.collection('Users');
  final CollectionReference CropsCollection =
      Firestore.instance.collection('Crops');

  Future UpdateUsersCollection(String name, String phonenumber) async {
    return await UsersCollection.document(uid)
        .setData({'name': name, 'phonenumber': phonenumber});
  }

  Future<bool> UpdateCropsCollection(
      String uid,
      String period,
      String season,
      String crop,
      String area,
      String areaunit,
      String productivity,
      String productivityunit,
      DateTime transplantingdate,String image) async {
    try {
      await CropsCollection.document(uid).setData({
        'uid': uid,
        'season': season,
        'period': period,
        'crop': crop,
        'area': area,
        'areaunit': areaunit,
        'productivity': productivity,
        'productivityunit': productivityunit,
        'transplantingdate': transplantingdate,
        'image':image,

      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      phonenumber: snapshot.data['phonenumber'],
    );
  }

  Crop _userProfileFromSnapshot(DocumentSnapshot snapshot) {
    return Crop(
      id:snapshot.data['id'],
      uid: snapshot.data['uid'],
      period: snapshot.data['period'],
      season: snapshot.data['season'],
      crop: snapshot.data['crop'],
      area: snapshot.data['area'],
      areaunit: snapshot.data['areaunit'],
      productivity: snapshot.data['productivity'],
      productivityunit: snapshot.data['productivityunit'],
      transplantingdate: snapshot.data["transplantingdate"],
      image: snapshot.data['image']
    );
  }

  //collection stream
  Stream<UserData> get userData {
    return UsersCollection.document(uid).snapshots().map(_userDataFromSnapShot);
  }

  Stream<Crop> get userProfile {
    return CropsCollection.document(uid)
        .snapshots()
        .map(_userProfileFromSnapshot);
  }

  Future<String> checkphonenumber(String phonenumber) async {
    String temp;
    QuerySnapshot querysnapshot =
        await UsersCollection.where("phonenumber", isEqualTo: phonenumber)
            .getDocuments();
    if (querysnapshot.documents != null) {
      String a = querysnapshot.documents[0]["name"];
      print(querysnapshot.documents[0]["phonenumber"]);
      //print(f);
      //print("in database $temp");
      return a;
    } else {
      return "";
    }
    //print("in database $temp");
    //return temp;
  }

  Future getmycrops(String uid) async {
    QuerySnapshot snapshot = await CropsCollection.where("uid",isEqualTo:uid).getDocuments();
    return snapshot.documents;
  }
  Future deletecrop(String name) async  {
    await CropsCollection.document(name).delete();
  }
}
