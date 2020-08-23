import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gexxx_flutter/app_localizations.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/pcrop.dart';
import 'package:gexxx_flutter/models/sharedpreference.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/addcrop_plan.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cropplan extends StatefulWidget {
  UserData userData;
  Cropplan({this.userData});
  @override
  _CropplanState createState() => _CropplanState();
}

class _CropplanState extends State<Cropplan> with TickerProviderStateMixin {
  SharedPref sharedPref = SharedPref();
  TabController tabController;
  String lang;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print("dfghj");
    getdata();
  }

  Pcrop crop = Pcrop();
  

  getdata() async {
    try {
      Pcrop c = Pcrop.fromJson(await sharedPref.read('cropplan'));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      lang = prefs.getString('language_code');
      print("dfghj111");
      setState(() {
        crop = c;
        this.lang = lang; 
      });
    } catch (e) {}
  }

Future<String> getstring() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tt = prefs.getString('language_code');
    print(tt);
    if(tt == null)
      {
        tt = 'en';
      }
    return tt;
  }

  List<PageController> pagecontrollers = [];

  Widget tabbody(Pcrop crop, String uid, String tt) {
    PageController pageController = PageController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: FutureBuilder(
            future: (tt == 'en') ? DefaultAssetBundle.of(context).loadString("Crop_database/crop_plan.json"):DefaultAssetBundle.of(context).loadString("Crop_database/crop_plan_hi.json"),
            builder: (context, snapshot) {
              
              if (snapshot.hasData) {
                dynamic crops = json.decode(snapshot.data.toString());
                DateTime cdate = crop.cultivationdate;
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

                int length = crops[crop.crop][0]['startdates'].length;
                int currentindex;
                for (int j = 0; j < length - 1; j++) {
                  if (buffer >= crops[crop.crop][0]['startdates'][j] &&
                      buffer < crops[crop.crop][0]['startdates'][j + 1]) {
                    currentindex = j;
                    break;
                  }
                  if (buffer <= crops[crop.crop][0]['startdates'][0]) {
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
                        controller: pageController,
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
                                    Text(AppLocalizations.of(context).translate('-- Current task --'),
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              crops[crop.crop][0]['tasks']
                                                  [currentindex],
                                              style: TextStyle(
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
                                              '[ ${DateTime.now().subtract(Duration(days: crops[crop.crop][0]['startdates'][currentindex])).day.toString()}-${DateTime.now().subtract(Duration(days: crops[crop.crop][0]['startdates'][currentindex])).month.toString()}-${DateTime.now().subtract(Duration(days: crops[crop.crop][0]['startdates'][currentindex])).year.toString()}  to  ${DateTime.now().add(Duration(days: crops[crop.crop][0]['enddates'][currentindex])).day.toString()}- ${DateTime.now().add(Duration(days: crops[crop.crop][0]['enddates'][currentindex])).month.toString()}- ${DateTime.now().add(Duration(days: crops[crop.crop][0]['enddates'][currentindex])).year.toString()} ]',
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.015,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              crops[crop.crop][0]['content']
                                                  [currentindex],
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
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          onPressed: () {
                                            pageController.previousPage(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.easeIn);
                                          },
                                        ),
                                        FlatButton(
                                          child: Text(
                                            'Next task',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          onPressed: () {
                                            pageController.nextPage(
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
                                            ? AppLocalizations.of(context).translate("-- Previous Task --")
                                            : AppLocalizations.of(context).translate("-- Upcoming task --"),
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              crops[crop.crop][0]['tasks']
                                                  [index2],
                                              style: TextStyle(
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
                                              '[ ${DateTime.now().add(Duration(days: crops[crop.crop][0]['startdates'][index2])).day.toString()}-${DateTime.now().add(Duration(days: crops[crop.crop][0]['startdates'][index2])).month.toString()}-${DateTime.now().add(Duration(days: crops[crop.crop][0]['startdates'][index2])).year.toString()}  to  ${DateTime.now().add(Duration(days: crops[crop.crop][0]['enddates'][index2])).day.toString()}- ${DateTime.now().add(Duration(days: crops[crop.crop][0]['enddates'][index2])).month.toString()}- ${DateTime.now().add(Duration(days: crops[crop.crop][0]['enddates'][index2])).year.toString()} ]',
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.015,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              crops[crop.crop][0]['content']
                                                  [index2],
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
                                            AppLocalizations.of(context).translate("Previous task"),
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          onPressed: () {
                                            pageController.previousPage(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.easeIn);
                                          },
                                        ),
                                        FlatButton(
                                          child: Text(
                                            AppLocalizations.of(context).translate("Next task"),
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          onPressed: () {
                                            pageController.nextPage(
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.red),
            child: FlatButton(
              onPressed: () {
                DatabaseService(uid: uid).removefav(crop).then((value) {
                  print(value);
                });
              },
              child: Text(
                AppLocalizations.of(context).translate('remove crop'),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String tt;
    getstring().then((value) => {
      tt = value
    });
    print(tt);
    return StreamBuilder<Object>(
        stream: DatabaseService(uid: user.uid).favcrop,
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            List<Pcrop> crops = snapshot.data;
            tabController = TabController(length: crops.length, vsync: this);
            return Scaffold(
              backgroundColor: Colors.grey[200],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addcropplan()));
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
                  child: crops.isEmpty
                      ? Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.arrow_back,
                                      color: Colors.black),
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.arrow_back,
                                      color: Colors.black),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            TabBar(
                              isScrollable: true,
                              indicatorColor: Colors.black,
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey[600],
                              indicatorPadding: EdgeInsets.only(left: 10),
                              tabs: crops.map((e) {
                                return Tab(
                                  text: e.crop,
                                );
                              }).toList(),
                              controller: tabController,
                            ),
                            Expanded(
                                child: TabBarView(
                              controller: tabController,
                              children: crops.map((e) {
                                return tabbody(e, user.uid,tt);
                              }).toList(),
                            ))
                          ],
                        ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
