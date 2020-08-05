import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/screens/wrapper.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';

class Username extends StatefulWidget {
  User user;
  Username({this.user});
  @override
  _UsernameState createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  bool statevisible = false;
  String selectedstate = 'Select state';
  String selecteddistrict = 'Select District';
  String village = '';
  String name = '';
  String phonenumber = '';
  int selectedstateindex;
  Widget _name() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)
          ]),
      child: TextFormField(
        keyboardType: TextInputType.text,
        maxLines: 1,
        inputFormatters: [LengthLimitingTextInputFormatter(100)],
        onChanged: (val) {
          setState(() {
            name = val;
          });
        },
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: MediaQuery.of(context).size.height * 0.015,
        ),
        decoration: InputDecoration(
          fillColor: Colors.black,
          border: InputBorder.none,
          hintText: 'Name',
          hintStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.height * 0.015,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget _village() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)
          ]),
      child: TextFormField(
        keyboardType: TextInputType.text,
        maxLines: 1,
        inputFormatters: [LengthLimitingTextInputFormatter(100)],
        onChanged: (val) {
          setState(() {
            village = val;
          });
        },
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: MediaQuery.of(context).size.height * 0.015,
        ),
        decoration: InputDecoration(
          fillColor: Colors.black,
          border: InputBorder.none,
          hintText: 'Village',
          hintStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.height * 0.015,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget location() {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Select state',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'openSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  statevisible = false;
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          backgroundColor: Colors.grey[900],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Scrollbar(
                                              child: FutureBuilder(
                                                future: DefaultAssetBundle.of(
                                                        context)
                                                    .loadString(
                                                        "State_names/State_names.json"),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (snapshot.data != null) {
                                                      dynamic state_list = json
                                                          .decode(snapshot.data
                                                              .toString());
                                                      return ListView.builder(
                                                          itemCount: state_list
                                                                  ?.length ??
                                                              0,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return InkWell(
                                                              splashColor:
                                                                  Colors.blue,
                                                              onTap: () {
                                                                setState(() {
                                                                  selectedstate =
                                                                      state_list[
                                                                              index]
                                                                          [
                                                                          "state"];
                                                                  selectedstateindex =
                                                                      index;
                                                                  Navigator.pop(
                                                                      context,
                                                                      selectedstate);
                                                                });
                                                              },
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.07,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        state_list[index]
                                                                            [
                                                                            "state"],
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontFamily:
                                                                                'OpenSans',
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    } else {
                                                      return new CircularProgressIndicator();
                                                    }
                                                  } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Container(
                                                        child: new Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: new Center(
                                                                child:
                                                                    new CircularProgressIndicator())));
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return new Text(
                                                      '${snapshot.error}',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    );
                                                  } else {
                                                    return Loading();
                                                  }
                                                },
                                              ),
                                            ),
                                          ));
                                    });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                    color: statevisible
                                        ? Colors.red[400]
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        selectedstate,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 15),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_circle,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Select District',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'openSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                          backgroundColor: Colors.grey[900],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Scrollbar(
                                              child: FutureBuilder(
                                                future: DefaultAssetBundle.of(
                                                        context)
                                                    .loadString(
                                                        "State_names/State_names.json"),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (snapshot.data != null) {
                                                      dynamic district_list =
                                                          json.decode(snapshot
                                                              .data
                                                              .toString());
                                                      return selectedstate !=
                                                              'Select state'
                                                          ? ListView.builder(
                                                              itemCount: district_list[
                                                                              selectedstateindex]
                                                                          [
                                                                          "districts"]
                                                                      ?.length ??
                                                                  0,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .blue,
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selecteddistrict =
                                                                          district_list[selectedstateindex]["districts"]
                                                                              [
                                                                              index];
                                                                      Navigator.pop(
                                                                          context,
                                                                          selectedstate);
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.07,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10.0),
                                                                      child:
                                                                          Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            district_list[selectedstateindex]["districts"][index],
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontFamily: 'OpenSans',
                                                                                fontWeight: FontWeight.bold),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              })
                                                          : Center(
                                                              child: Text(
                                                                'please select state',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            );
                                                    } else {
                                                      return new CircularProgressIndicator();
                                                    }
                                                  } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Container(
                                                        child: new Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: new Center(
                                                                child:
                                                                    new CircularProgressIndicator())));
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return new Text(
                                                      '${snapshot.error}',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    );
                                                  } else {
                                                    return Loading();
                                                  }
                                                },
                                              ),
                                            ),
                                          ));
                                    });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        selecteddistrict,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 15),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_circle,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            _village(),
                            SizedBox(height: 20),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'okay',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            });
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'location',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
          )),
    );
  }

  Widget state() {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  backgroundColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Scrollbar(
                      child: FutureBuilder(
                        future: DefaultAssetBundle.of(context)
                            .loadString("State_names/State_names.json"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              dynamic state_list =
                                  json.decode(snapshot.data.toString());
                              return ListView.builder(
                                  itemCount: state_list?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      splashColor: Colors.grey[600],
                                      onTap: () {
                                        setState(() {
                                          selectedstate =
                                              state_list[index]["state"];
                                          selectedstateindex = index;
                                          selecteddistrict = 'Select District';
                                          Navigator.pop(context, selectedstate);
                                        });
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                state_list[index]["state"],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return new CircularProgressIndicator();
                            }
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                                child: new Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: new Center(
                                        child:
                                            new CircularProgressIndicator())));
                          } else if (snapshot.hasError) {
                            return new Text(
                              '${snapshot.error}',
                              style: TextStyle(color: Colors.red),
                            );
                          } else {
                            return Loading();
                          }
                        },
                      ),
                    ),
                  ));
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            color: statevisible ? Colors.red[400] : Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedstate,
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget district() {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Scrollbar(
                      child: FutureBuilder(
                        future: DefaultAssetBundle.of(context)
                            .loadString("State_names/State_names.json"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              dynamic district_list =
                                  json.decode(snapshot.data.toString());
                              return selectedstate != 'Select state'
                                  ? ListView.builder(
                                      itemCount:
                                          district_list[selectedstateindex]
                                                      ["districts"]
                                                  ?.length ??
                                              0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          splashColor: Colors.blue,
                                          onTap: () {
                                            setState(() {
                                              selecteddistrict = district_list[
                                                      selectedstateindex]
                                                  ["districts"][index];
                                              Navigator.pop(
                                                  context, selectedstate);
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    district_list[
                                                            selectedstateindex]
                                                        ["districts"][index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'OpenSans',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: Text(
                                        'please select state',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    );
                            } else {
                              return new CircularProgressIndicator();
                            }
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                                child: new Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: new Center(
                                        child:
                                            new CircularProgressIndicator())));
                          } else if (snapshot.hasError) {
                            return new Text(
                              '${snapshot.error}',
                              style: TextStyle(color: Colors.red),
                            );
                          } else {
                            return Loading();
                          }
                        },
                      ),
                    ),
                  ));
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: Colors.grey[200], blurRadius: 5, spreadRadius: 1)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selecteddistrict,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _phonenumber() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.grey[200], blurRadius: 5, spreadRadius: 1)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'IN +91',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Container(
                width: 1,
                height: MediaQuery.of(context).size.height * 0.03,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.phone,
                maxLines: 1,
                inputFormatters: [LengthLimitingTextInputFormatter(100)],
                onChanged: (val) {
                  setState(() {
                    phonenumber = val;
                  });
                },
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                ),
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  border: InputBorder.none,
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontFamily: 'OpenSans'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Get',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: MediaQuery.of(context).size.width * 0.06),
                ),
                Text(
                  'Started',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.065),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black,
                  height: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),

                _name(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'State',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),

                state(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'District',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                district(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Village',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                _village(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Phone Number',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 5,
                ),

                _phonenumber(),
                SizedBox(
                  height: 40,
                ),

                //location(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (name.isNotEmpty &&
              selectedstate != 'Select state' &&
              selecteddistrict != 'Select District' &&
              village.isNotEmpty &&
              phonenumber.isNotEmpty) {
            print('valid');
            DatabaseService(uid: widget.user.uid).UpdateUserDetails(
                name,
                phonenumber,
                '',
                '',
                selectedstate,
                selectedstateindex,
                selecteddistrict,
                village,
                '',
                '',
                '', []).then((value) {
              if (value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Wrapper(),
                    ),
                    (route) => false);
              }
            });
          } else {
            print('$name');
            print('$selectedstate');
            print('$selecteddistrict');
            print('$village');
            print('$phonenumber');
          }
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.done, color: Colors.white),
      ),
    );
  }
}
