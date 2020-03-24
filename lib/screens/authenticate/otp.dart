import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gexxx_flutter/screens/Phone_code.dart';
import 'package:gexxx_flutter/screens/wrapper.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/constants.dart';

class Otp extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<Otp> {
  String phonenumber;
  String code = '91';
  String image = 'https://restcountries.eu/data/ind.svg';
  String verificationID;
  String smsCode;

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  _phonecode(BuildContext context) async {
    final dynamic result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Phone_code()));
    setState(() {
      code = result.dial_code;
      image = result.imageval;
    });
    print(code);
  }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
      this.verificationID = verID;
    };

    final PhoneCodeSent smsCodeSent = (String verID, [int forceCodeResend]) {
      this.verificationID = verID;
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential authResults) {
      AuthService().signInWithphone(authResults);
    } as PhoneVerificationCompleted;

    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      print('${exception.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: this.phonenumber,
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifiedFailed,
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter sms code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              new FlatButton(
                onPressed: (){
                  FirebaseAuth.instance.currentUser().then((user){
                    if(user!=null)
                    {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Wrapper()));

                    }
                    else
                    {
                      Navigator.of(context).pop();
                    }
                  });
                }, 
                child: Text('Done'))
            ],
          );
        });
  }

  sigIn(){
    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              new Row(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.black,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.blue))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.075,
                            height: MediaQuery.of(context).size.height * 0.03,
                            child: SvgPicture.network(
                              '$image',
                              placeholderBuilder: (context) {
                                CircularProgressIndicator();
                              },
                              fit: BoxFit.fill,
                            ),
                          ),
                          /*Image(
                                width: MediaQuery.of(context).size.width * 0.085,
                                height: MediaQuery.of(context).size.height * 0.03,
                                image: new NetworkImage(
                                    "$image"),
                                fit: BoxFit.fill),*/
                          MyVerticalDivider(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Center(
                              child: new Text(
                                "$code",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down,
                              size: 30, color: Colors.white),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      _phonecode(context);
                    },
                  ),
                  SizedBox(width: 1),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.57,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          this.phonenumber = '+' + code + val;
                        });
                      },
                      validator: (val) =>
                          val.isEmpty ? 'Enter Phone Number' : null,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.left,
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
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                width: 300,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    verifyPhone();
                  },
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(
                    'GET OTP',
                    style: TextStyle(
                      color: Color(0xFF527DAA),
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              ),
              _buildSignInWithText(),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () => print('Login Button Pressed'),
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/logos/google.jpg'),
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Signin with Google',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () => print('Login Button Pressed'),
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/logos/facebook.jpg'),
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Signin with Facebook',
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
