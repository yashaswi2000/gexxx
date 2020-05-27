import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/language.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/Dashboard.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/Languagepage.dart';
import 'package:gexxx_flutter/screens/authenticate/login2.dart';
import 'package:gexxx_flutter/screens/wrapper.dart';
class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var actualcode;

  User _userFromFirebaseUser(FirebaseUser user){

    return user!=null? User(uid:user.uid):null;
    
  }
  //auth change user stream

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);

  }
  handleAuth(){
    return StreamBuilder(
      stream:_auth.onAuthStateChanged,
      builder: (BuildContext context,snapshot){
        if(snapshot.hasData){
          return Wrapper();

        }
        else{
          return LanguagePage();
        }
      },
    );
  }
  // Sign in anon
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
  Future signInWithEmailAndPassword(String email,String password) async
  {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /*Future registerWithEmailAndPassword(String email,String password,String name) async
  {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //create a document for userdata
      await DatabaseService(uid: user.uid).UpdateUsersCollection(name, email);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  

  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    _auth.signInWithCredential(authCreds);
  }

  Future signInWithOTP(smsCode, verId) async{
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    await _auth.signInWithCredential(authCreds).then((AuthResult result){
      
    });
  }
}