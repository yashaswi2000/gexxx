import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/Cropslist.dart';
import 'package:gexxx_flutter/screens/authenticate/phoneverificationpage.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/constants.dart';

class Otp extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<Otp> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String phonenumber;
  String verificationId;
  String code = '91';
  String image = 'https://restcountries.eu/data/ind.svg';
  String verificationID;
  String smsCode;
   bool codeSent = false;
  bool isvalid = false;

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
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          this.phonenumber = val;
                          isvalid = true;
                        });
                      },
                      validator: (val) => val.isEmpty && val.length != 10
                          ? 'Phone Number is Required'
                          : null,
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
                ),
                Visibility(
                  child: Text(
                    "Enter a 10 Digit Phone Number",
                    style: TextStyle(color: Colors.red),
                  ),
                  visible: !isvalid,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  width: 300,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        if (phonenumber.length != 10) {
                          setState(() {
                            isvalid = false;
                          });
                        } else {
                          setState(() {
                            isvalid = true;
                          });
                          
                            verifyPhone(this.phonenumber);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Phoneverificationpage(verificationId: this.verificationID,)));
                            
                        }
                      }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
