import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/Areaunit.dart';
import 'package:gexxx_flutter/models/Period.dart';
import 'package:gexxx_flutter/models/Season.dart';
import 'package:gexxx_flutter/models/language.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class Editprofile extends StatefulWidget {
  final UserData userData;

  const Editprofile({Key key, this.userData}) : super(key: key);

  @override
  _EditprofileScreenState createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<Editprofile> {
  List<String> genderlist = ["Male", "Female"];
  @override
  void initState() {
    super.initState();
    selectedstate = widget.userData.state;
    selecteddistrict = widget.userData.district;
    name = widget.userData.name;
    village = widget.userData.village;
    age = widget.userData.age;
    gender = widget.userData.gender;
    image = widget.userData.image;
    statenumber = widget.userData.statenumber;
    uid = widget.userData.uid;
    languagecode = widget.userData.languagecode;
    language = widget.userData.language;
  }

  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();

  String selectedstate;
  String selecteddistrict;
  String name;
  String village;
  String age;
  String gender;
  String image;
  int statenumber;
  String uid;
  String language;
  String languagecode;

  bool namevisible = false;
  bool disctrictvisible = false;
  bool isloading = false;

  Widget _district() {
    return GestureDetector(
      onTap: () {
        setState(() {
          disctrictvisible = false;
        });
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                                      itemCount: district_list[statenumber]
                                                  ["districts"]
                                              ?.length ??
                                          0,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          splashColor: Colors.blue,
                                          onTap: () {
                                            setState(() {
                                              selecteddistrict =
                                                  district_list[statenumber]
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
                                                0.07,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    district_list[statenumber]
                                                        ["districts"][index],
                                                    style: TextStyle(
                                                        color: Colors.white,
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
                  ),
                ),
              );
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            color: disctrictvisible ? Colors.red : Colors.grey[800],
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selecteddistrict,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _state() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                                      splashColor: Colors.blue,
                                      onTap: () {
                                        setState(() {
                                          selectedstate =
                                              state_list[index]["state"];
                                          statenumber = index;
                                          selecteddistrict = '';
                                          Navigator.pop(context, selectedstate);
                                        });
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                state_list[index]["state"],
                                                style: TextStyle(
                                                    color: Colors.white,
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
                  ),
                ),
              );
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            color: Colors.grey[800], borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedstate,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _name() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: namevisible ? Colors.red : Colors.grey[800],
          borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        onChanged: (val) {
          setState(() {
            name = val;
            namevisible = false;
          });
        },
        initialValue: name,
        validator: (val) => val.isEmpty ? 'Enter the name' : null,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20),
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.yellow,
          prefixIcon: Icon(Icons.person, color: Colors.white),
          border: InputBorder.none,
          hintText: 'name',
          hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget _age() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: Colors.grey[800], borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        onChanged: (val) {
          setState(() {
            age = val;
          });
        },
        initialValue: age,
        validator: (val) => val.isEmpty ? 'Enter the age' : null,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20),
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.yellow,
          prefixIcon: Icon(Icons.person, color: Colors.white),
          border: InputBorder.none,
          hintText: 'age',
          hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget _village() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: Colors.grey[800], borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        onChanged: (val) {
          setState(() {
            village = val;
          });
        },
        initialValue: village,
        validator: (val) => val.isEmpty ? 'Enter the name' : null,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20),
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.yellow,
          prefixIcon: Icon(Icons.person, color: Colors.white),
          border: InputBorder.none,
          hintText: 'village',
          hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  Widget _gender() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scrollbar(
                      child: ListView.builder(
                          itemCount: genderlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                setState(() {
                                  gender = genderlist[index];
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        genderlist[index],
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
                          }),
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            color: Colors.grey[800], borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                gender,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'OpenSans', fontSize: 15),
              ),
              Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLongToast() {
    Fluttertoast.showToast(
      msg: "Profile Updated",
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return isloading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.grey[800],
              title: Text('Add Crop'),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      Row(
                        children: <Widget>[
                          Text(
                            'Name',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'openSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      _name(),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            'Select state',
                            style: TextStyle(
                                color: namevisible ? Colors.red : Colors.white,
                                fontFamily: 'openSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      _state(),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            'Select district',
                            style: TextStyle(
                              color:
                                  disctrictvisible ? Colors.red : Colors.white,
                              fontFamily: 'openSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      _district(),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            'village',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'openSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _village(),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            'Age',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'openSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _age(),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            'Gender',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'openSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      _gender(),
                      SizedBox(height: 20),
                      FloatingActionButton.extended(
                        backgroundColor: Colors.blue,
                        isExtended: true,
                        label: Text('Done'),
                        elevation: 10,
                        tooltip: 'pressing this button will a add a crop',
                        onPressed: () async {
                          if (name.isEmpty) {
                            setState(() {
                              namevisible = true;
                            });
                          }
                          if (selecteddistrict.isEmpty) {
                            setState(() {
                              disctrictvisible = true;
                            });
                          }

                          if (namevisible == false &&
                              disctrictvisible == false) {
                            setState(() {
                              isloading = true;
                            });
                            dynamic result = await DatabaseService(uid: uid)
                                .UpdateUserDetails(
                                    name,
                                    widget.userData.phonenumber,
                                    gender,
                                    age,
                                    selectedstate,
                                    statenumber,
                                    selecteddistrict,
                                    village,
                                    image,
                                    language,
                                    languagecode, []);
                            if (result == true) {
                              setState(() {
                                isloading = false;
                              });
                              //Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("crop is added"),));
                              showLongToast();
                              Navigator.pop(context);
                            }
                          }
                        },
                        icon: Icon(Icons.done),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
