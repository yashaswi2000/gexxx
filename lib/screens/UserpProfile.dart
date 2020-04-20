import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/authenticate/Email.dart';
import 'package:gexxx_flutter/screens/authenticate/otp.dart';
import 'package:gexxx_flutter/screens/editprofile.dart';
import 'package:gexxx_flutter/screens/mycrop.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:gexxx_flutter/utilities/MyverticalDivider2.dart';

class UserProfile extends StatefulWidget {
  final User user;

  const UserProfile({Key key, this.user}) : super(key: key);
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  QuerySnapshot snapshot;
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    var result = DatabaseService(uid: widget.user.uid).getuserdocument();
    print('sa');
    print(result.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15),
            MyhorizontalDivider(),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.21,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness==Brightness.light?Colors.grey[800]:Colors.teal,
                    borderRadius: BorderRadius.circular(5)),
                child: FutureBuilder(
                    future:
                        DatabaseService(uid: widget.user.uid).getuserdocument(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        UserData userData = snapshot.data;
                        return Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.15,
                  backgroundImage:
                      AssetImage("assets/images/wheat1.jpg"),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                MyVerticalDivider2(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 10),
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
                            userData.name,
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
                            userData.state,
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
                            userData.phonenumber,
                            style: TextStyle(
                                color: Colors.white, fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                                              child: Row(
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Editprofile(
                                                userData: userData,
                                              )));
                                },
                                color: Colors.blue[600],
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(
                                            5.0),
                                    side: BorderSide(
                                        color: Colors.white,
                                        width: 2)),
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
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          backgroundColor:
                                              Colors.grey[800],
                                          shape:
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                              10)),
                                          child: Container(
                                            height:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                            width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets
                                                      .all(10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                      height: 20),
                                                  CircleAvatar(
                                                    radius: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        0.13,
                                                    backgroundImage:
                                                        AssetImage(
                                                            'assets/images/wheat1.jpg'),
                                                  ),
                                                  SizedBox(
                                                      height: 20),
                                                  Divider(
                                                    color:
                                                        Colors.white,
                                                    height: 2,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .only(
                                                            bottom:
                                                                10.0),
                                                    child: Row(
                                                      children: <
                                                          Widget>[
                                                        AutoSizeText(
                                                          'name : ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          userData
                                                              .name,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .only(
                                                            bottom:
                                                                10.0),
                                                    child: Row(
                                                      children: <
                                                          Widget>[
                                                        AutoSizeText(
                                                          'age : ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          userData
                                                              .age,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .only(
                                                            bottom:
                                                                10.0),
                                                    child: Row(
                                                      children: <
                                                          Widget>[
                                                        AutoSizeText(
                                                          'gender : ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          userData
                                                              .gender,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .only(
                                                            bottom:
                                                                10.0),
                                                    child: Row(
                                                      children: <
                                                          Widget>[
                                                        AutoSizeText(
                                                          'state : ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          userData
                                                              .state,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .only(
                                                            bottom:
                                                                10.0),
                                                    child: Row(
                                                      children: <
                                                          Widget>[
                                                        AutoSizeText(
                                                          'district : ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          userData
                                                              .district,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets
                                                                .only(
                                                            bottom:
                                                                10.0),
                                                    child: Row(
                                                      children: <
                                                          Widget>[
                                                        AutoSizeText(
                                                          'village : ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          userData
                                                              .village,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize:
                                                                  18),
                                                          maxLines: 1,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                    });

                                    print(userData.age);
                              },
                              child: Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
                        );
                      } else if (snapshot.hasError) {
                        return new Text(
            '${snapshot.error}',
            style: TextStyle(color: Colors.red),
                        );
                      } else if (snapshot.connectionState ==
            ConnectionState.waiting) {
                        return Container(
              child: new Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Center(
                      child: new CircularProgressIndicator())));
                      } else {
                        return Loading();
                      }
                    }),
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
                //height: MediaQuery.of(context).size.height*0.4,
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
        ));
  }
}
