import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/authenticate/AuthenticationHome.dart';

import './Login.dart';
import 'package:flutter/services.dart';

import './signup.dart';
import 'Email.dart';
import 'Password.dart';
import 'otp.dart';

class Login extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login>
    with SingleTickerProviderStateMixin {
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
      body: SingleChildScrollView(
              child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            
            children: <Widget>[
              SizedBox(height: 60),
              Container(
                margin: EdgeInsets.only(left:10),
                child:Row(
                  children: <Widget>[
                    
                    IconButton(icon: Icon(Icons.arrow_back,size: 25,color: Colors.white),onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthenticationHome()));
                    },),
                    SizedBox(width: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                                  child: Text(
                      'Login with',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),
              ),
                    ),
                  ],
                )),
              SizedBox(height: 40.0),
              TabBar(
                  controller: tabController,
                  indicatorColor: Colors.blue,
                  indicatorWeight: 3.0,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "OTP",
                        style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Password",
                        style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Email",
                        style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                      ),
                    ),
                  ]),
              Expanded(
                child: Container(
                  child: TabBarView(controller: tabController, children: <Widget>[
                    Otp(),
                    Password(),
                    Email(),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
