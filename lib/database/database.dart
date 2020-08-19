import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gexxx_flutter/models/article.dart';
import 'package:gexxx_flutter/models/pcrop.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:gexxx_flutter/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference UsersCollection =
      Firestore.instance.collection('Users');
  final CollectionReference CropsCollection =
      Firestore.instance.collection('Crops');

  final CollectionReference MarketCollection =
      Firestore.instance.collection('pricelist');

  final CollectionReference PoliciesCollection =
      Firestore.instance.collection('policies');

  final CollectionReference PestsCollection =
      Firestore.instance.collection('pests');

  Future<bool> updatefavorites(String crop) async {
    try {
      await UsersCollection.document(uid).updateData({
        'favouritecrops': FieldValue.arrayUnion([crop])
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> UpdateUserDetails(
      String name,
      String phonenumber,
      String gender,
      String age,
      String state,
      int statenumber,
      String district,
      String village,
      String image,
      String language,
      String languagecode,
      List<Pcrop> favouritecrops) async {
    try {
      await UsersCollection.document(uid).setData({
        'uid': uid,
        'name': name,
        'gender': gender,
        'age': age,
        'state': state,
        'district': district,
        'village': village,
        'image': image,
        'phonenumber': phonenumber,
        'statenumber': statenumber,
        'language': language,
        'languagecode': languagecode,
        'favouritecrops': favouritecrops.map((e) => e.toJson()).toList()
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> addfavcrop(Pcrop pcrop) async {
    try {
      await UsersCollection.document(uid).updateData({
        'favouritecrops': FieldValue.arrayUnion([pcrop.toJson()]),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> removefav(Pcrop pcrop) async {
    try {
      await UsersCollection.document(uid).updateData({
        'favouritecrops': FieldValue.arrayRemove([pcrop.toJson()]),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<DocumentSnapshot>> getpolicies(String category) async {
    try {
      QuerySnapshot qs =
          await PoliciesCollection.where('category', isEqualTo: category)
              .getDocuments();
      return qs.documents.map((e) {
        return e;
      }).toList();
    } catch (e) {}
  }

  Future<List<DocumentSnapshot>> getpests(String crop) async {
    try {
      QuerySnapshot qs =
          await PestsCollection.where('cropname', isEqualTo: 'Tomato')
              .getDocuments();

      return qs.documents.map((e) {
        return e;
      }).toList();
    } catch (e) {}
  }

  Future<bool> cropexists(String crop) async {
    try {
      await UsersCollection.document(uid).snapshots().map((event) {
        event.data['favoritecrops'].map((crops) {
          if (crops['crop'] == crop) {
            return true;
          }
        });
      });
      return false;
    } catch (e) {}
  }

  Future<bool> UpdateCropsCollection(
      String uid,
      String season,
      String crop,
      String area,
      String areaunit,
      String productivity,
      String productivityunit,
      DateTime transplantingdate,
      String image,
      String landtype,
      String landtopography,
      String landsize,
      String landsizeunit,
      String soil) async {
    try {
      await UsersCollection.document(uid)
          .collection('crops')
          .document(crop)
          .setData({
        'uid': uid,
        'season': season,
        'crop': crop,
        'area': area,
        'areaunit': areaunit,
        'productivity': productivity,
        'productivityunit': productivityunit,
        'transplantingdate': transplantingdate,
        'image': image,
        'landtype': landtype,
        'landtopography': landtopography,
        'landsize': landsize,
        'landsizeunit': landsizeunit,
        'soil': soil,
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
        name: snapshot.data["name"],
        phonenumber: snapshot.data["phonenumber"],
        state: snapshot.data["state"],
        village: snapshot.data["village"],
        district: snapshot.data["district"],
        gender: snapshot.data["gender"],
        image: snapshot.data["image"],
        age: snapshot.data["age"],
        statenumber: snapshot.data["statenumber"],
        language: snapshot.data["language"],
        favouritecrops: snapshot.data['favouritecrops'].map<Pcrop>((e) {
          return Pcrop.fromJson(e);
        }).toList(),
        languagecode: snapshot.data["languagecode"]);
  }

  //collection stream
  Stream<UserData> get userData {
    return UsersCollection.document(uid).snapshots().map(_userDataFromSnapShot);
  }

  List<Pcrop> _favDataFromSnapShot(DocumentSnapshot snapshot) {
    return snapshot.data['favouritecrops'].map<Pcrop>((e) {
      return Pcrop.fromJson(e);
    }).toList();
  }

  Stream<List<Pcrop>> get favcrop {
    return UsersCollection.document(uid).snapshots().map(_favDataFromSnapShot);
  }

  _marketDataFromSnapshot(QuerySnapshot querysnapshot) {
    return querysnapshot.documents.map((snapshot) {
      print(snapshot);
      return snapshot;
    }).toList();
  }

  Stream get market {
    return MarketCollection.snapshots().map(_marketDataFromSnapshot);
  }

  final CollectionReference NewsCollection =
      Firestore.instance.collection('news');
  List<Article> _newsDataFromSnapShot(QuerySnapshot querySnapshot) {
    return querySnapshot.documents.map((snapshot) {
      final translator = new GoogleTranslator();
      var trans = snapshot.data['title'];
      var translation = null;
      SharedPreferences.getInstance().then((prefs) async => {
            print(prefs.getString('language_code') + "temp"),
            //translator.translateAndPrint("I would buy a car, if I had money.",to: 'hi'),
            //translator.translate(snapshot.data['title'], from: 'en', to: prefs.getString('language_code')).then((value) => {
            //  print(value)
            // })
          });
      //var translation = await translator.translate(snapshot.data['title'], from: 'en', to: pref.getString('language_code'));
      return Article(
          title: trans,
          summary: snapshot.data['summary'],
          articlelink: snapshot.data['articlelink'],
          image: snapshot.data['img'],
          publishdate: snapshot.data['publishdate']);
    }).toList();
  }

  Stream<List<Article>> get news {
    return NewsCollection.snapshots().map(_newsDataFromSnapShot);
  }

  Future<UserData> checkphonenumber(String phonenumber) async {
    QuerySnapshot querysnapshot =
        await UsersCollection.where("phonenumber", isEqualTo: phonenumber)
            .getDocuments();

    if (querysnapshot.documents.isNotEmpty) {
      return UserData(
        uid: querysnapshot.documents[0]["uid"],
        name: querysnapshot.documents[0]["name"],
        phonenumber: querysnapshot.documents[0]["phonenumber"],
        state: querysnapshot.documents[0]["state"],
        district: querysnapshot.documents[0]["district"],
        village: querysnapshot.documents[0]["village"],
        age: querysnapshot.documents[0]["age"],
        gender: querysnapshot.documents[0]["gender"],
        statenumber: querysnapshot.documents[0]["statenumber"],
        image: querysnapshot.documents[0]["image"],
        language: querysnapshot.documents[0]["language"],
        languagecode: querysnapshot.documents[0]["languagecode"],
      );
    } else {
      return null;
    }
  }

  Future<bool> checklocation() async {
    DocumentSnapshot snapshot = await UsersCollection.document(uid).get();
    if (snapshot.data["state"] == '') {
      return false;
    } else {
      return true;
    }
  }

  Future<UserData> getuserdocument() async {
    DocumentSnapshot snapshot1 = await UsersCollection.document(uid).get();

    if (snapshot1.data.isNotEmpty) {
      return UserData(
        uid: uid,
        name: snapshot1.data["name"],
        phonenumber: snapshot1.data["phonenumber"],
        state: snapshot1.data["state"],
        village: snapshot1.data["village"],
        district: snapshot1.data["district"],
        gender: snapshot1.data["gender"],
        image: snapshot1.data["image"],
        statenumber: snapshot1.data["statenumber"],
        age: snapshot1.data["age"],
        language: snapshot1.data["language"],
        languagecode: snapshot1.data["languagecode"],
      );
    } else {
      return null;
    }
  }

  Future getmycrops(String uid) async {
    QuerySnapshot snapshot =
        await UsersCollection.document(uid).collection('crops').getDocuments();
    return snapshot.documents;
  }

  Future deletecrop(String name) async {
    await UsersCollection.document(uid)
        .collection('crops')
        .document(name)
        .delete();
  }
}
