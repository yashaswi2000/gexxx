import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/authenticate/Password.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/constants.dart';

class addcrop extends StatefulWidget {
  @override
  _addcropScreenState createState() => _addcropScreenState();
}

class _addcropScreenState extends State<addcrop> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String error = '';
  String name = '';
  String email = '';
  String password = '';
  String password2 = '';
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _password2controller = TextEditingController();

  Widget _name() {
    return TextFormField(
      controller: _namecontroller,
      validator: (val) => val.isEmpty ? 'Enter Your name' : null,
      autofocus: true,
      autocorrect: true,
      onChanged: (val) {
        setState(() {
          name = val;
        });
      },
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: "Email",
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.mail, color: Colors.white),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(16)),
        hintText: 'Enter your Name',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _email() {
    return TextFormField(
      controller: _emailcontroller,
      validator: (val) => val.isEmpty ? 'Enter Email Address' : null,
      keyboardType: TextInputType.emailAddress,
      autofocus: true,
      autocorrect: true,
      onChanged: (val) {
        setState(() {
          email = val;
        });
      },
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: "Email",
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.mail, color: Colors.white),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(16)),
        hintText: 'Enter your Email',
        hintStyle: TextStyle(color: Colors.grey),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        hintText: 'Enter your Password',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _password2() {
    return TextFormField(
      validator: (val) => val != password ? 'Password Donot Match' : null,
      controller: _password2controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      autofocus: true,
      autocorrect: true,
      onChanged: (val) {
        setState(() {
          password2 = val;
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        hintText: 'Enter your Password Again',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (_formkey.currentState.validate()) {
            dynamic result =
                await _auth.registerWithEmailAndPassword(email, password, name);
            if (result == null) {
              setState(() {
                error = 'Please Suplly valid Email';
              });
            } else {
              Navigator.pop(context,true);
            }

            print(name);
            print(email);
            print(password);
            print(password2);
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Signup',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 60),
                    Row(
                      
                      children: <Widget>[
                        SizedBox(width: 20),
                        Text(
                          'AddCrop',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: _name()),
                    SizedBox(height: 30.0),
                    _email(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _password(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _password2(),
                    SizedBox(height: 10),
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
                    _buildSignupBtn(),
                  ],
                ),
              ),
      ),
      );
  }
}
