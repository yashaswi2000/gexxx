import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/language.dart';
import 'package:gexxx_flutter/models/user.dart';

import 'package:gexxx_flutter/services/auth.dart';

class LoginPage extends StatefulWidget {
  final Language language;

  const LoginPage({Key key, this.language}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();
  String phoneNo, verificationId, smsCode;
  String name;
  String initial_name;
  String uid;
  bool codeSent = false;
  bool isUser = false;
  bool visible = false;
  UserData userData;
  bool checking = false;
  String errormessage = '';

  @override
  Widget build(BuildContext context) {
    return checking
        ? Container(
            color: Colors.teal,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(
                    child: new CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ))))
        : Scaffold(
            backgroundColor: Colors.teal,
            body: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Center(
                              child: Text(
                            'Registration',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )),
                        ),
                        SizedBox(height: 30),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 25.0, right: 25.0, bottom: 10),
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              onChanged: (val) async {
                                setState(() {
                                  visible = false;
                                });

                                if (val.length == 10) {
                                  setState(() {
                                    this.checking = true;
                                  });
                                  UserData result = await DatabaseService()
                                      .checkphonenumber(val);

                                  print("in login $result");
                                  if (result != null) {
                                    print('result is $result');
                                    setState(() {
                                      userData = result;
                                      phoneNo = val;

                                      this.name = userData.name;
                                      nameController.text = userData.name;
                                      phoneController.text = val;

                                      isUser = true;
                                    });
                                  } else {
                                    print('yesss');
                                    setState(() {
                                      phoneNo = val;

                                      nameController.text = '';
                                      isUser = false;
                                      phoneController.text = val;
                                    });
                                  }
                                  setState(() {
                                    this.checking = false;
                                  });
                                }
                              },
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.yellow,
                                prefixIcon:
                                    Icon(Icons.phone, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[800], width: 2),
                                    borderRadius: BorderRadius.circular(16)),
                                hintText: 'Enter 10 Digit Phone Number',
                                hintStyle: TextStyle(
                                    color: Colors.grey[800], fontSize: 15),
                              ),
                              validator: (val) =>
                                  val.isEmpty && val.length != 10
                                      ? 'Phone Number is Required'
                                      : null,
                            )),
                        Visibility(
                          child: Text(
                            "Enter a 10 Digit Phone Number",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold),
                          ),
                          visible: visible,
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 25.0, right: 25.0, bottom: 10),
                            child: TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              onChanged: (val) async {
                                if (isUser) {
                                  print('is user $nameController.txt');
                                  setState(() {
                                    this.name = nameController.text;
                                  });
                                  print('is name $nameController.txt');
                                } else {
                                  setState(() {
                                    this.name = val;
                                  });
                                }
                              },
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.yellow,
                                prefixIcon:
                                    Icon(Icons.people, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[800], width: 2),
                                    borderRadius: BorderRadius.circular(16)),
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(
                                    color: Colors.grey[800], fontSize: 15),
                              ),
                              validator: (val) =>
                                  val.isEmpty ? 'Name is Required' : null,
                            )),
                        codeSent
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: 10,
                                    left: 25.0,
                                    right: 25.0,
                                    bottom: 10),
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    focusColor: Colors.red,
                                    prefixIcon:
                                        Icon(Icons.people, color: Colors.white),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[800], width: 2),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    hintText: 'Enter OTP',
                                    hintStyle: TextStyle(
                                        color: Colors.grey[800], fontSize: 15),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      this.smsCode = val;
                                    });
                                  },
                                ))
                            : Container(),
                        SizedBox(height: 30),
                        Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: FlatButton(
                                  color: Colors.grey[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                      child: codeSent
                                          ? Text(
                                              'LOGIN',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: 5),
                                            )
                                          : Text(
                                              'GET OTP',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: 5),
                                            )),
                                  onPressed: () async {
                                    if (formKey.currentState.validate()) {
                                      if (phoneController.text.length.toInt() !=
                                          10) {
                                        setState(() {
                                          visible = true;
                                        });
                                      } else {
                                        setState(() {
                                          visible = false;
                                          errormessage = '';
                                        });

                                        await verifyPhone(phoneNo);

                                        if (codeSent) {
                                          setState(() {
                                            checking = true;
                                          });

                                          AuthCredential authCreds =
                                              PhoneAuthProvider.getCredential(
                                                  verificationId:
                                                      verificationId,
                                                  smsCode: smsCode);

                                          try {
                                            AuthResult result =
                                                await FirebaseAuth.instance
                                                    .signInWithCredential(
                                                        authCreds);
                                            setState(() {
                                              uid = result.user.uid;
                                            });
                                          } catch (e) {
                                            setState(() {
                                              checking = false;
                                            });
                                            //Navigator.pop(context);
                                            print('in error');
                                            handleError(e);
                                          }

                                          if (errormessage == '') {
                                            print('no error');
                                            if (isUser) {
                                              await DatabaseService(uid: uid)
                                                  .UpdateUserDetails(
                                                      name,
                                                      phoneNo,
                                                      userData.gender,
                                                      userData.age,
                                                      userData.state,
                                                      userData.statenumber,
                                                      userData.district,
                                                      userData.village,
                                                      userData.image,
                                                      widget.language.Name,
                                                      widget.language.code);
                                            } else {
                                              print('new user');
                                              await DatabaseService(uid: uid)
                                                  .UpdateUserDetails(
                                                      name,
                                                      phoneNo,
                                                      '',
                                                      '',
                                                      '',
                                                      0,
                                                      '',
                                                      '',
                                                      '',
                                                      widget.language.Name,
                                                      widget.language.code);
                                            }

                                            Navigator.pop(context);
                                           setState(() {
                                              checking = false;
                                            });
                                          }

                                          /* try{
                                                  FirebaseAuth.instance
                                              .signInWithCredential(authCreds)
                                              .then((AuthResult result) async {
                                            
                                            
                                            //Navigator.pop(context);
                                           /* setState(() {
                                              checking = false;
                                            });*/
                                          });
                                          } on PlatformException catch(e)
                                          {
                                            print('got error');
                                            handleError(e);
                                          }*/

                                        }
                                      }
                                    }
                                  }),
                            )),
                        errormessage != ''
                            ? Text(
                                errormessage,
                                style: TextStyle(color: Colors.white),
                              )
                            : Container(),
                      ],
                    ),
                  )),
            ),
          );
  }

  handleError(PlatformException error) {
    print('in error');
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        setState(() {
          errormessage = 'Invalid Code';
        });
        break;
    }
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;

      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      setState(() {
        this.codeSent = true;
      });
      this.verificationId = verId;
    };

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91' + phoneNo,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verified,
          verificationFailed: verificationfailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: null);
    } catch (e) {
      print(e.toString());
    }
  }
}