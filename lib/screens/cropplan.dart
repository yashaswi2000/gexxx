import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gexxx_flutter/models/pcrop.dart';
import 'package:gexxx_flutter/models/sharedpreference.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/addcrop_plan.dart';

class Cropplan extends StatefulWidget {
  UserData userData;
  Cropplan({this.userData});
  @override
  _CropplanState createState() => _CropplanState();
}

class _CropplanState extends State<Cropplan>
    with SingleTickerProviderStateMixin {
  SharedPref sharedPref = SharedPref();
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
        length: widget.userData.favouritecrops.length, vsync: this);
    getdata();
  }

  Pcrop crop = Pcrop();

  getdata() async {
    try {
      Pcrop c = Pcrop.fromJson(await sharedPref.read('cropplan'));
      setState(() {
        crop = c;
      });
    } catch (e) {}
  }

  List<PageController> pagecontrollers = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [];
    List<Widget> tabbarviews = [];
    for (int i = 0; i < widget.userData.favouritecrops.length; i++) {
      tabs.add(Tab(
        text: widget.userData.favouritecrops[i].crop,
      ));
      tabbarviews.add(FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString("Crop_database/crop_plan.json"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic crops = json.decode(snapshot.data.toString());
            DateTime cdate = widget.userData.favouritecrops[i].cultivationdate;
            int days = cdate.difference(DateTime.now()).inDays;

            int hrs = cdate.difference(DateTime.now()).inHours;

            int buffer;
            if (days == 0) {
              if (hrs > 0) {
                if (hrs <= 24) {
                  buffer = 1;
                } else {
                  if (hrs >= 24) {
                    buffer = -1;
                  }
                }
              }
              if (hrs == 0) {
                buffer = 0;
              } else {
                buffer = 0;
              }
            } else {
              if (hrs > 0) {
                buffer = (hrs / 24).ceil();
              } else {
                buffer = days;
              }
            }

            int length = crops[widget.userData.favouritecrops[i].crop][0]
                    ['startdates']
                .length;
            int currentindex;
            for (int j = 0; j < length - 1; j++) {
              if (buffer >=
                      crops[widget.userData.favouritecrops[i].crop][0]
                          ['startdates'][j] &&
                  buffer <
                      crops[widget.userData.favouritecrops[i].crop][0]
                          ['startdates'][j + 1]) {
                currentindex = j;
                break;
              }
              if (buffer <=
                  crops[widget.userData.favouritecrops[i].crop][0]['startdates']
                      [0]) {
                currentindex = 0;
                break;
              }
            }
            if (currentindex == null) {
              currentindex = length - 1;
            }
            pagecontrollers.add(PageController(initialPage: currentindex));

            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: PageView.builder(
                    pageSnapping: true,
                    controller: pagecontrollers[i],
                    itemCount: length,
                    itemBuilder: (c, index2) {
                      if (index2 == currentindex) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('-- Current task --',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          crops[widget
                                              .userData
                                              .favouritecrops[i]
                                              .crop][0]['tasks'][currentindex],
                                          style:
                                              TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.018,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          '[ ${DateTime.now().subtract(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['startdates'][currentindex])).day.toString()}-${DateTime.now().subtract(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['startdates'][currentindex])).month.toString()}-${DateTime.now().subtract(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['startdates'][currentindex])).year.toString()}  to  ${DateTime.now().add(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['enddates'][currentindex])).day.toString()}- ${DateTime.now().add(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['enddates'][currentindex])).month.toString()}- ${DateTime.now().add(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['enddates'][currentindex])).year.toString()} ]',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.015,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          crops[widget.userData
                                                  .favouritecrops[i].crop][0]
                                              ['content'][currentindex],
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Previous task',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onPressed: () {
                                        pagecontrollers[i].previousPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeIn);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        'Next task',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onPressed: () {
                                        pagecontrollers[i].nextPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeIn);
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    index2 < currentindex
                                        ? '-- Previous Task --'
                                        : '-- Upcoming task --',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.018,
                                        color: index2 < currentindex
                                            ? Colors.red
                                            : Colors.green,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          crops[widget
                                              .userData
                                              .favouritecrops[i]
                                              .crop][0]['tasks'][index2],
                                          style:
                                              TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.018,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          '[ ${DateTime.now().add(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['startdates'][index2])).day.toString()}-${DateTime.now().add(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['startdates'][index2])).month.toString()}-${DateTime.now().add(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['startdates'][index2])).year.toString()}  to  ${DateTime.now().add(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['enddates'][index2])).day.toString()}- ${DateTime.now().add(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['enddates'][index2])).month.toString()}- ${DateTime.now().add(Duration(days: crops[widget.userData.favouritecrops[i].crop][0]['enddates'][index2])).year.toString()} ]',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.015,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          crops[widget
                                              .userData
                                              .favouritecrops[i]
                                              .crop][0]['content'][index2],
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Previous task',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onPressed: () {
                                        pagecontrollers[i].previousPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeIn);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text(
                                        'Next task',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onPressed: () {
                                        pagecontrollers[i].nextPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeIn);
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ));
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addcropplan()));
        },
        backgroundColor: Colors.grey[800],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: widget.userData.favouritecrops.isEmpty
              ? Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Expanded(
                        child: Center(
                      child: Text(
                        'Your crop plan is empty',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                )
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey[600],
                          indicatorPadding: EdgeInsets.only(left: 10),
                          tabs: tabs,
                          controller: tabController,
                        ),
                      ],
                    ),
                    Expanded(
                        child: TabBarView(
                            controller: tabController, children: tabbarviews))
                  ],
                ),
        ),
      ),
    );
  }
}
