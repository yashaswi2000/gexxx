import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/CropProfile.dart';
import 'package:gexxx_flutter/screens/Cropslist.dart';
import 'package:gexxx_flutter/screens/MainDrawer.dart';
import 'package:gexxx_flutter/screens/addcrop.dart';
import 'package:gexxx_flutter/screens/NewsPage.dart';
import 'package:gexxx_flutter/screens/authenticate/AuthenticationHome.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:gexxx_flutter/database/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  final User user;

  const Home({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  Map data;
  List CropData;

  Future getData() async {
    http.Response response = await http.get(
        "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b&format=json&offset=0&limit=30");
    data = json.decode(response.body);
    //debugPrint(response.body);
    setState(() {
      CropData = data["records"];
    });

    //debugPrint(CropData.toString());
    //print(CropData.length);
  }

  Container MyFeed(String crop_name, String state) {
    return Container(
      margin: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          AutoSizeText(
            crop_name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            minFontSize: 15,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          AutoSizeText(
            state,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  GestureDetector cropcircle(String imageval, String crop_name) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CropProfile(cropname: crop_name, price: 'Rs 18')),
        );
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(imageval), fit: BoxFit.fill)),
          ),
          SizedBox(height: 10),
          Text(
            crop_name,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  GestureDetector MyCrop(String imageval, String crop_name, String price) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CropProfile(cropname: crop_name, price: price)),
          );
        },
        child: Row(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(color: Colors.grey[800]),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(imageval),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        crop_name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                )),
            //MyVerticalDivider2(),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  FlatButton.icon(
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthenticationHome()));
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
                title: Center(
                  child: Text('GEXXX'),
                ),
                backgroundColor: Colors.black,
              ),
              backgroundColor: Colors.black,
              drawer: MainDrawer(),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(20)),
                            /*child: Center(
                                child: Text('Welcome ${userData.name}',
                                    style: TextStyle(color: Colors.white))),*/
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 15, bottom: 15),
                              child: Row(
                                children: <Widget>[
                                  cropcircle(
                                      'https://images.unsplash.com/photo-1529511582893-2d7e684dd128?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                                      'wheat'),
                                  SizedBox(width: 20),
                                cropcircle(
                                      'https://images.unsplash.com/photo-1567461007299-4df855e56ed3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80',
                                      'paddy'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          FloatingActionButton(
                            child: Icon(Icons.add, size: 50.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addcrop()));
                            },
                          ),
                        ],
                      ),
                    ),

                    // Stack(

                    //       children: <Widget>[
                    //         Container(
                    //       margin: EdgeInsets.only(top: 20,left:20,right:20),
                    //     height: MediaQuery.of(context).size.height * 0.18,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(color: Colors.grey[900],borderRadius: BorderRadius.circular(10)),
                    //     child:Center(child: Text('Empty',style: TextStyle(color: Colors.white),)),
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 50.0),
                    //           child: Center(
                    //             child:  ,
                    //           ),
                    //         ),
                    //       ]),

                    /*Container(
                    decoration: BoxDecoration(color: Colors.black),
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: CropData == null ? 0 : CropData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return //Text('as');
                              MyCrop(
                                  "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=701&q=80",
                                  "${CropData[index]["variety"]}",
                                  "${CropData[index]["modal_price"]}");
                        })),*/
                    SizedBox(
                      height: 20,
                    ),
                    MyhorizontalDivider(),
                    SizedBox(height: 20),
                    Text(
                      'CARDS',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          fontFamily: "OpenSans"),
                    ),
                    
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: RaisedButton(
                          elevation: 5.0,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage()));
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.blue[800],
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'News',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 40,
                              )
                            ],
                          )),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: RaisedButton(
                          elevation: 5.0,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Cropslist()));
                          },
                              
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.blue[800],
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Crops',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 40,
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ));
        });
  }
}

class News {
}
