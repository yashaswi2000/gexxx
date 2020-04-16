
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:provider/provider.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(user.uid,style: TextStyle(color: Colors.black),),
          Center(
            child: RaisedButton(
              child: Text('Signout'),
              onPressed: () {
                AuthService().signOut();
              },
            )
          ),
        ],
      )
    );
  }
}