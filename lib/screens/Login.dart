import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/Email.dart';
import 'package:gexxx_flutter/screens/Password.dart';

import 'package:gexxx_flutter/screens/otp.dart';
import '../screens/Login.dart';
import 'package:flutter/services.dart';
import '../utilities/constants.dart';
import '../screens/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> with SingleTickerProviderStateMixin {
 TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 70.0),
            child: Row(
              children: <Widget>[
                Text(
                        'Login With',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ],
            ),
          ),
         
          SizedBox(height: 40.0),
          TabBar(
            controller: tabController,
            indicatorColor: Colors.indigo,
              indicatorWeight: 3.0,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Text("OTP", style: TextStyle(
                    
                    fontSize: 20,
                    fontFamily: 'OpenSans'
                  ),),
                ),
                Tab(
                  child: Text("Password", style: TextStyle(
                      
                      fontSize: 20,
                      fontFamily: 'OpenSans'
                  ),),
                ),
                Tab(
                  child: Text("Email", style: TextStyle(
                      
                      fontSize: 20,
                      fontFamily: 'OpenSans'
                  ),),
                ),
                
              ]),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: tabController,
                  children: <Widget>[
                    Otp(),
                    Password(),
                    Email(),
              ]),
            ),
          )
        ],
      ),

    );
  }
}

