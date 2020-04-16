import 'package:flutter/material.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/authenticate/AuthenticationHome.dart';
import 'package:gexxx_flutter/screens/authenticate/login2.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate
    final user = Provider.of<User>(context);
    print("in warapper $user");
    if(user==null)
    {
      return  LoginPage();
    }
    else{
      return Home(user: user);
    }
    
  }
}