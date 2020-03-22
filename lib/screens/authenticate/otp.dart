import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/Phone_code.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/constants.dart';

class Otp extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<Otp> {
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
              Row(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.black,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.blue))),
                      child: Row(
                        children: <Widget>[
                          Image(
                              width: MediaQuery.of(context).size.width * 0.095,
                              height: MediaQuery.of(context).size.height * 0.03,
                              image: NetworkImage(
                                  "https://cdn.pixabay.com/photo/2016/08/24/17/07/india-1617463__340.png"),
                              fit: BoxFit.fill),
                          MyVerticalDivider(),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.095,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: Center(
                              child: Text(
                                '+91',
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
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Phone_code()));
                      print('code pressed');
                    },
                  ),
                  SizedBox(width: 1),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.57,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter Email Address' : null,
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusColor: Colors.yellow,
                        prefixIcon: Icon(Icons.phone, color: Colors.white),
                        border: InputBorder.none,
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
                  onPressed: () => print('Login Button Pressed'),
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
