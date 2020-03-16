
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/AuthenticationHome.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/Settings.dart';


import 'screens/Login.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // this is our
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: AuthenticationHome(),
      routes:<String,WidgetBuilder>{
        "/settings":(BuildContext context)=>new Settings("Settings"),
      },
    );
  }
}