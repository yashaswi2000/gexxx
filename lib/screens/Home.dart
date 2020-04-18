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
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:gexxx_flutter/database/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:translator/translator.dart';

class Home extends StatefulWidget {
  final User user;

  const Home({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  Map data;
  List CropData;
  String news = 'news';
  final translate = new GoogleTranslator();

  Future getData() async {
    http.Response response = await http.get(
        "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b&format=json&offset=0&limit=30");
    data = json.decode(response.body);
    //debugPrint(response.body);
    setState(() {
      CropData = data["records"];
    });
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
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(3.0),
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
            SizedBox(height: 8),
            Text(
              crop_name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector MyCrop(String imageval, String crop_name, String price) {
    var cropt = translate.translate(crop_name, to: 'kn');

    return GestureDetector(
        onTap: () {},
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
    
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          
          if(snapshot.hasData)
          {
            UserData userData = snapshot.data;
             return Scaffold(
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Center(
                        child: AutoSizeText(
                          'Welcome ${userData.name},This is Agriculture Based App , we Provide News,Crops Details and we provider a tracker for your cultivation',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.normal,
                              fontSize: 13),
                        ),
                      ),
                      SizedBox(height: 20),
                      MyhorizontalDivider(),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.12,
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(20)),
                          /*child: Center(
                            child: Text('Welcome ${userData.name}',
                                style: TextStyle(color: Colors.white))),*/
                          child: Center(
                            child: Text(
                              'Empty',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      MyhorizontalDivider(),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AutoSizeText(
                            'To add a crop press this button',
                            style: TextStyle(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          FloatingActionButton.extended(
                            backgroundColor: Colors.blue,
                            isExtended: true,
                            label: Text('Add a Crop'),
                            elevation: 10,
                            tooltip: 'Add a Crop',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addcrop()));
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      MyhorizontalDivider(),
                      SizedBox(height: 15),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: RaisedButton(
                            elevation: 5.0,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cropslist()));
                            },
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.blue[800],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'All Crops in India',
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
                      
                    ],
                  ),
                ),
              ));

          }
          else if(snapshot.hasError)
          {
            return new Text(
                      '${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    );
          }
          return Loading();
         
        });
  }
}
