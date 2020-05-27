import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/addcrop.dart';

import 'package:gexxx_flutter/screens/editprofile.dart';
import 'package:gexxx_flutter/screens/mycrop.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:gexxx_flutter/utilities/MyverticalDivider2.dart';
import 'package:gexxx_flutter/utilities/constants.dart';

class UserProfile extends StatefulWidget {
  final UserData userData;

  const UserProfile({Key key, this.userData}) : super(key: key);
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
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        body: SafeArea(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                         width: MediaQuery.of(context).size.width*0.4,
                height: MediaQuery.of(context).size.height * 0.20,
                        child: Center(
                          child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.13,
                              backgroundImage: AssetImage("assets/images/wheat1.jpg"),
                            ),
                        ),
                      ),
                      MyVerticalDivider(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white,
                        width: 0.5,
                        height: MediaQuery.of(context).size.height * 0.18,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Center(
                                    child: Icon(
                  Icons.person,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: AutoSizeText(
                  widget.userData.name,
                  style: TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                             
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone,
                                    
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: AutoSizeText(
                  widget.userData.phonenumber,
                  style: TextStyle(fontWeight: FontWeight.w500),
                                     
                  overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              
                              Row(
                                children: <Widget>[
                                  Center(
                                    child: Icon(
                  Icons.location_on,
                                    
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: AutoSizeText(
                  widget.userData.state,
                  style: TextStyle(fontWeight: FontWeight.w500),
                                     
                  overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              
                             
                            ],
                          ),
                        ),
                      )
                    ],
                ),
              ),
               Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                      color: kThemeColor, borderRadius: BorderRadius.circular(5)),
                child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                       
                        
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: FloatingActionButton(
                                onPressed: () {
                                   Navigator.push(context,MaterialPageRoute(builder: (context)=>Editprofile(userData: widget.userData,)));
                                },
                                heroTag: 'tag2',
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.edit,
                                  color: kThemeColor,
                                ),
                              )),
                        ),
                         Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: FloatingActionButton(
                                onPressed: () {
                                   Navigator.push(context,MaterialPageRoute(builder: (context)=>addcrop()));
                                },
                                heroTag: 'tag1',
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.add,
                                  color: kThemeColor,
                                ),
                              )),
                        ),
                      ],
                    ),
                ),
              ),
               ),
                
              TabBar(
                    controller: tabController,
                    indicatorColor: Colors.blue,
                    indicatorWeight: 2.0,
                    labelColor: kThemeColor,
                    labelStyle: TextStyle(
                        fontFamily: 'Circular', fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          "CROP",
                         
                        ),
                      ),
                      Tab(
                        child: Text(
                          "TRACKER",
                         
                        ),
                      ),
                    ]),
              Expanded(
                              child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    MyCrop(),
                    Text('hi', style: TextStyle(color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
