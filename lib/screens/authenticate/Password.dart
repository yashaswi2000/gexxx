import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gexxx_flutter/screens/Phone_code.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/constants.dart';
import './otp.dart';

class Password extends StatefulWidget {
  

  
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<Password> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  
  String email,password;
  String code='91';
  String image = 'https://restcountries.eu/data/ind.svg';
  
   

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

  _phonecode(BuildContext context) async{
    final dynamic result =  await Navigator.push(context, MaterialPageRoute(builder: (context)=>Phone_code()));
    setState(() {
      code =result.dial_code;
      image = result.imageval;
    });
    print(code);

    
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new SingleChildScrollView(
        child: Form(
          key: _formkey,
                  child: new Column(
            
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
                                placeholderBuilder: (context){
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
                      onPressed: () async{
                        _phonecode(context);
                        
                      },
                    ),
                    SizedBox(width: 1),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.57,
                      
                      
                      child: TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter Phone Number' : null,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.left,
                        
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusColor: Colors.yellow,
                          prefixIcon: Icon(Icons.phone, color: Colors.white),
                          enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            
            borderRadius: BorderRadius.circular(16)),
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
                  onPressed: () {
                    if(_formkey.currentState.validate())
                    {

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
