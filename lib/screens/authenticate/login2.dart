import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/screens/authenticate/phoneverificationpage.dart';
import 'package:gexxx_flutter/services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  var nameController = new TextEditingController();
  String phoneNo, verificationId, smsCode;
  String name;
  String initial_name;
  bool codeSent = false;
  bool isUser = false;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
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
                        keyboardType: TextInputType.phone,
                        onChanged: (val) async {
                          if(val.length==10)
                          {
                            dynamic result = await DatabaseService().checkphonenumber(val);
                            print("in login $result");
                            if(result.length!=0)
                            {
                              setState(() {
                                this.phoneNo = val;
                                visible = false;
                                this.name = result;
                                nameController.text = result;
                                
                                isUser = true;
                              });
                            }
                            else{
                                setState(() {
                                  this.phoneNo= val;
                                  visible = false;
                                  nameController.text= '';
                                  isUser = false;
                                });
                            }
                          }
                          
                          
                        },
                        
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusColor: Colors.yellow,
                          prefixIcon: Icon(Icons.phone, color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(16)),
                          hintText: 'Enter 10 Digit Phone Number',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        validator: (val) => val.isEmpty && val.length != 10
                            ? 'Phone Number is Required'
                            : null,
                      )),
                  Visibility(
                    child: Text(
                      "Enter a 10 Digit Phone Number",
                      style: TextStyle(color: Colors.red),
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
                          if(isUser)
                          {
                            print('is user $nameController.txt');
                            setState(() {
                              this.name = nameController.text;
                            });
                            print('is name $nameController.txt');
                          }
                          else
                          {
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
                          prefixIcon: Icon(Icons.people, color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(16)),
                          hintText: 'Enter your name',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Name is Required' : null,
                      )),
                  codeSent
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 25.0, right: 25.0, bottom: 10),
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              focusColor: Colors.yellow,
                              prefixIcon:
                                  Icon(Icons.people, color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(16)),
                              hintText: 'Enter OTP',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15),
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
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Center(
                                child:
                                    codeSent ? Text('Login') : Text('verify')),
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                if (phoneNo.length != 10) {
                                  setState(() {
                                    visible = true;
                                  });
                                } else {
                                  setState(() {
                                    visible = false;
                                  });
                                  verifyPhone(phoneNo);
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>Phoneverificationpage(verificationId: verificationId,phonenumber: phoneNo,)));

                                  if (codeSent) {
                                    //AuthService().signInWithOTP(smsCode, verificationId);
                                    AuthCredential authCreds =
                                        PhoneAuthProvider.getCredential(
                                            verificationId: verificationId,
                                            smsCode: smsCode);
                                    FirebaseAuth.instance
                                        .signInWithCredential(authCreds)
                                        .then((AuthResult result) async {
                                          await DatabaseService(uid: result.user.uid).UpdateUsersCollection(name, phoneNo);
                                        });
                                    //DatabaseService(uid: user.uid).UpdateUsersCollection(name, email);

                                  } else {
                                    verifyPhone(phoneNo);
                                  }
                                }
                              }
                            }),
                      ))
                ],
              ),
            )),
      ),
    );
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
        this.codeSent =  true;
      });
      this.verificationId = verId;
    };

    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }catch(e)
    {
      print(e.toString());

    }
  }
    
}
