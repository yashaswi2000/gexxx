import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/authenticate/signup.dart';
import 'package:gexxx_flutter/screens/wrapper.dart';




class AuthenticationHome extends StatefulWidget {
  @override
  _AuthenticationHomeScreenState createState() =>
      _AuthenticationHomeScreenState();
}

class _AuthenticationHomeScreenState extends State<AuthenticationHome> {

  bool loggedin = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loggedin ? Wrapper(): Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
              child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 200, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                SizedBox(height: 30),
                
                
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: ()async {
                      final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup(),fullscreenDialog: true));
                      if(result== true)
                      {
                        //print('usercreated');
                        loggedin = true;
                      }
                    },
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: Colors.blueGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Register',
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
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: ()async {
                      //final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>Login(),fullscreenDialog: true));
                    //Navigator.pop(context);
                    
      
                      
                    },
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: Colors.blueGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Login',
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
      ),
    );
    
  }
}
