
import 'package:flutter/material.dart';

import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/Phone_code.dart';
import 'package:gexxx_flutter/screens/Settings.dart';
import 'package:gexxx_flutter/screens/additionaldetails.dart';
import 'package:gexxx_flutter/screens/wrapper.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // this is our
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
          child: MaterialApp(
        title: 'Flutter Login UI',
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes:<String,WidgetBuilder>{
          "/settings":(BuildContext context)=>new Settings("Settings"),
        },
      ),
    );
  }
}