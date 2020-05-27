import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/Languagepage.dart';
import 'package:gexxx_flutter/screens/wrapper.dart';
import 'package:gexxx_flutter/services/auth.dart';

import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.dark,
      data: (brightness) => new ThemeData(
        primarySwatch: Colors.teal,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return StreamProvider<User>.value(
            value: AuthService().user,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Wrapper(),
              theme: theme,
            ));
      }
    );
  }
  
  
}