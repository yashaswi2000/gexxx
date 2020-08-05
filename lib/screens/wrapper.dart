import 'package:flutter/material.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/Dashboard.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/Languagepage.dart';
import 'package:gexxx_flutter/screens/authenticate/authenticatehome.dart';

import 'package:gexxx_flutter/screens/authenticate/login2.dart';
import 'package:gexxx_flutter/screens/authenticate/username.dart';
import 'package:gexxx_flutter/screens/bottomnavigation.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate
    final user = Provider.of<User>(context);
    print("in warapper $user");
    if (user == null) {
      return AuthenticateHome();
    } else {
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home(
                userData: snapshot.data,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Username(user: user);
            }
          });
    }
  }
}
