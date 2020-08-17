import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/pcrop.dart';
import 'package:gexxx_flutter/models/sharedpreference.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/cropplan.dart';
import 'package:provider/provider.dart';

class Addcropplan extends StatefulWidget {
  @override
  _AddcropplanState createState() => _AddcropplanState();
}

class _AddcropplanState extends State<Addcropplan> {
  String selected_crop = '';
  int selectedindex;
  DateTime cdate = DateTime.now();
  Future<DateTime> _projectdeadline(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked == null) {
      return DateTime.now();
    } else {
      return picked;
    }
  }

  SharedPref sharedPref = SharedPref();

  Widget date() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: InkWell(
        onTap: () {
          _projectdeadline(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  '${cdate.day}-${cdate.month}-${cdate.year}',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cancelButton = FlatButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: Colors.black),
    ),
    onPressed: () {},
  );
  Widget continueButton = FlatButton(
    child: Text("Continue", style: TextStyle(color: Colors.black)),
    onPressed: () {},
  );

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
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
                FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString("Crop_database/crop_plan.json"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      dynamic crops = json.decode(snapshot.data.toString());
                      print(crops['croplist'].length);
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: crops['croplist'].length,
                          itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter setState) {
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0)),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.28,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          crops['croplist'][i],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.02,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.clear,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Date of Cultivation',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        _projectdeadline(
                                                                context)
                                                            .then((value) {
                                                          setState(() =>
                                                              cdate = value);
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.blue),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons
                                                                    .calendar_today,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '${cdate.day}-${cdate.month}-${cdate.year}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selected_crop =
                                                                  crops['croplist']
                                                                      [i];
                                                            });
                                                            DatabaseService(
                                                                    uid: user
                                                                        .uid)
                                                                .addfavcrop(Pcrop(
                                                                    crop:
                                                                        selected_crop,
                                                                    cultivationdate:
                                                                        cdate,
                                                                    id: selected_crop +
                                                                        cdate
                                                                            .toString()));
                                                            Navigator.pop(
                                                                context);
                                                            Navigator.pop(
                                                                context);

                                                            showToast(
                                                                'crop plan is added');
                                                          },
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.04,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .grey[800]),
                                                            child: Center(
                                                              child: Text(
                                                                'Update',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10,
                                        top: 20,
                                        bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          crops['croplist'][i],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
