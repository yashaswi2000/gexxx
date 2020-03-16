import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerScreenState createState() => _MainDrawerScreenState();
}

class _MainDrawerScreenState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          color: Colors.black,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          height: 300,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=701&q=80'),fit: BoxFit.fill),


                    ),
                ),
                 Text(
                        'Rohit',
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
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title:  Text(
                        'Settings',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: ()=> Navigator.of(context).pushNamed("/settings"),
                      )
        

      ],
    ));
  }
}
