import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/Phone_code.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/constants.dart';
import './otp.dart';

class Password extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<Password> {
  
  String email,password;
  Widget _email() {
    return TextFormField(
      
      
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
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(16)),
        hintText: 'Enter your Email',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
   Widget _code() {
    return TextFormField(
      
      
      validator: (val) => val.isEmpty ? 'Enter Code' : null,
      keyboardType: TextInputType.phone,
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
        
        labelText: "+91",
        fillColor: Colors.white,
       suffixIcon: Icon(Icons.arrow_downward,size: 25),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(16)),
        hintText: '+91',
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

 

  

  

  
  Widget _password() {
    return TextFormField(
      validator: (val) =>
          val.length < 6 ? 'Enter Password of atleast 6 Characters' : null,
     
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
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
            SizedBox(height: 20),
            _password(),
            SizedBox(height: 20),
            GestureDetector(
                           onTap: (){
                             print('forgot password pressed');
                           },
                          child: Container(
                            margin: EdgeInsets.only(right:10),
                            child: Align(
                              alignment: Alignment.centerRight,
                                                        child: Text('Forgot Password?',
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
                        ) ,
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.0),
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
    );
  }
}
