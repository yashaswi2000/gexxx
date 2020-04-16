import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'package:gexxx_flutter/utilities/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Email extends StatefulWidget {
  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<Email> {
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  Widget _email() {
    return TextFormField(
      controller: _emailcontroller,
      validator: (val) => val.isEmpty ? 'Enter Email Address' : null,
      keyboardType: TextInputType.emailAddress,
      onChanged: (val) {
        setState(() {
          email = val;
        });
      },
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
         hintText: 'Enter your Email',
        hintStyle: TextStyle(color: Colors.grey),
        labelText: "Email",
        prefixIcon: Icon(Icons.mail, color: Colors.white),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(16)),
       
      ),
    );
  }

  Widget _password() {
    return TextFormField(
      validator: (val) =>
          val.length < 6 ? 'Enter Password of atleast 6 Characters' : null,
      controller: _passwordcontroller,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      autofocus: true,
      autocorrect: true,
      onChanged: (val) {
        setState(() {
          password = val;
        });
      },
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(16)),
        hintText: 'Enter your Password',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.indigo,
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
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        _email(),
                        SizedBox(height: 20),
                        _password(),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            print('forgot password pressed');
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot Password?',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          width: 300,
                          child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Invalid Credentials';
                                    loading = false;
                                  });
                                } else {
                                  Navigator.pop(context, true);
                                }
                              }
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.white,
                            child: Text(
                              'Login',
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
                        SizedBox(height: 5),
                        Center(
                          child: Text(
                            error,
                            style: TextStyle(
                              color: Colors.red,
                              letterSpacing: 1.5,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                       
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
