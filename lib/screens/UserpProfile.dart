import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/screens/authenticate/Email.dart';
import 'package:gexxx_flutter/screens/authenticate/otp.dart';
import 'package:gexxx_flutter/screens/mycrop.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:gexxx_flutter/utilities/MyverticalDivider2.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfile>
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
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15),
          MyhorizontalDivider(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.15,
                    backgroundImage: AssetImage("assets/images/wheat1.jpg"),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  MyVerticalDivider2(),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            AutoSizeText(
                              'Rohit',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.my_location,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            AutoSizeText(
                              'Hyderabad',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            AutoSizeText(
                              '7032670785',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        FlatButton(
                            onPressed: () {},
                            color: Colors.blue[600],
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(
                                    color: Colors.white, width: 2)),
                            padding: EdgeInsets.all(10),
                            textColor: Colors.white,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(width: 10),
                                Text('Edit your profile'),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          MyhorizontalDivider(),
          SizedBox(
            height: 10,
          ),
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
                    "CROP",
                    style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                  ),
                ),
                Tab(
                  child: Text(
                    "LAND",
                    style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                  ),
                ),
                Tab(
                  child: Text(
                    "TRACKER",
                    style: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
                  ),
                ),
              ]),
          Expanded(
                      child: Container(
              //height: MediaQuery.of(context).size.height*0.6,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  MyCrop(),
                  Text('hi', style: TextStyle(color: Colors.white)),
                  Text('hi', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
