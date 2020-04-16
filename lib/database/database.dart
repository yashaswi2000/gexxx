//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gexxx_flutter/models/Crop.dart';
import 'package:gexxx_flutter/models/UserProfile.dart';


import 'package:gexxx_flutter/models/user.dart';


class DatabaseService{
  final String uid;

 
   DatabaseService({this.uid});

  final CollectionReference UsersCollection =  Firestore.instance.collection('Users');
  final CollectionReference UserProfileCollection = Firestore.instance.collection('Userprofile');
 

  Future UpdateUsersCollection(String name,String phonenumber)async
  {
    return await UsersCollection.document(uid).setData({
      'name':name,
      'phonenumber':phonenumber
    });
  }

  Future UpdateProfileCollection(String location,String soiltype,String landsize,double waterlevel,String language)async
  {
    return await UserProfileCollection.document(uid).setData({
      'location':location,
      'soiltype':soiltype,
      'landsize':landsize,
      'waterlevel':waterlevel,
      'lannguage':language,
    });
  }

  
   UserData  _userDataFromSnapShot(DocumentSnapshot snapshot)
  {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      phonenumber: snapshot.data['phonenumber'],
    );
  }

 


  UserProfile _userProfileFromSnapshot(DocumentSnapshot snapshot){
      return UserProfile(
        uid: uid,
        location: snapshot.data['location'],
        soiltype: snapshot.data['soiltype'],
        landsize: snapshot.data['landsize'],
        waterlevel: snapshot.data['waterlevel'],
        language:snapshot.data['language'],
      );
    }
    
      //collection stream
      Stream<UserData> get userData{
        return UsersCollection.document(uid).snapshots().map(_userDataFromSnapShot);
    
      }
    
      Stream<UserProfile> get userProfile {
        return UserProfileCollection.document(uid).snapshots().map(_userProfileFromSnapshot);
      }
    
      Future<String> checkphonenumber(String phonenumber) async 
      {
        String temp;
        QuerySnapshot querysnapshot = await UsersCollection.where("phonenumber", isEqualTo: phonenumber).getDocuments();
        if(querysnapshot.documents!=null)
        {
           String a = querysnapshot.documents[0]["name"];
           print(querysnapshot.documents[0]["phonenumber"]);
          //print(f);
          //print("in database $temp");
          return a;
        }
        else
        {
          return "";
        }
        //print("in database $temp");
        //return temp;
      }
    
    }
  
