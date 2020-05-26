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
import 'package:gexxx_flutter/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:gexxx_flutter/database/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:translator/translator.dart';

class Home extends StatefulWidget {
<<<<<<< Updated upstream
  final User user;

  const Home({Key key, this.user}) : super(key: key);
=======
  final UserData user;
 

  Home(
      {Key key,
      this.user,
     })
      : super(key: key);
>>>>>>> Stashed changes

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

<<<<<<< Updated upstream
  Container MyFeed(String crop_name, String state) {
=======
 Future getlocation(String uid) async {
    bool temp = await DatabaseService(uid: uid).checklocation();
    if (mounted) {
      setState(() {
        islocation = temp;
      });
    }
  }

  Widget _village() {
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
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
=======
  

 
  bool islocation = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isloadingweather = true;
    });
    //_getweather();
    setState(() {
      isloadingweather = false;
    });

    DatabaseService(uid: widget.user.uid).UsersCollection;

    dynamic result = getlocation(widget.user.uid);
  }

  

  void showLongToast() {
    Fluttertoast.showToast(
      msg: "Crop is added",
      toastLength: Toast.LENGTH_LONG,
>>>>>>> Stashed changes
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
 
  Widget ActionCard(
      String title, IconData icon, Color color, Function onPressed) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed,
      child: Ink(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.23,
        decoration: BoxDecoration(
            color:  Theme.of(context).brightness == Brightness.light?Colors.white:Colors.grey[800],
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color:  Theme.of(context).brightness == Brightness.light?Colors.grey[200]:Colors.black,
                blurRadius: 4,
                spreadRadius:2,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w400,color: Theme.of(context).brightness == Brightness.light? Colors.black:Colors.white),
                  
            ),
          ],
        ),
      ),
    );
  }
 
 
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
<<<<<<< Updated upstream

=======
   
>>>>>>> Stashed changes
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          
          if(snapshot.hasData)
          {
            UserData userData = snapshot.data;
<<<<<<< Updated upstream
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
=======
            name = userData.name.toUpperCase();
            return Scaffold(
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                       
                        SizedBox(height: 20),
                        Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 20,
                          runSpacing: 20,
                          children: <Widget>[
                            ActionCard('All Crops', Icons.tab, kThemeColor, () {Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Cropslist()));}),
                            ActionCard('Policies', Icons.panorama_wide_angle,
                                Colors.red, () {}),
                            ActionCard('News', Icons.public, kThemeColor, () {}),
                            ActionCard(
                                'Weather', WeatherIcons.day_sunny, kThemeColor, () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WeatherPage(
                                         
                                        )));}),
                            ActionCard(
                                'About us', Icons.priority_high, Colors.red, () {}),
                            ActionCard(
                                'Log out', Icons.people, kThemeColor, () {
                                 
                                }),
                          ],
                        ),
                      ),
                        //MyhorizontalDivider(),
                        /*InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WeatherPage(
                                          currentWeatherData:
                                              widget.currentWeatherData,
                                          dailyWeatherlist:
                                              widget.dailyweatherlist,
                                        )));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.10,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(20)),
                            child: _weather(widget.currentWeatherData),
                          ),
                        ),*/
                        //MyhorizontalDivider(),
                        SizedBox(height: 20),
                        
              
                        InkWell(
                          onTap: () {
                            print(userData.statenumber);
                            if (islocation) {
                              setState(() {
                                selectedstate = userData.state;
                                selectedstateindex = userData.statenumber;
                                village = userData.village;
                              });

                              print('stet is $selectedstateindex');
                            }

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.grey[900],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    content: StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        'Select state',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'openSans',
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      900],
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child:
                                                                    Scrollbar(
                                                                  child:
                                                                      FutureBuilder(
                                                                    future: DefaultAssetBundle.of(
                                                                            context)
                                                                        .loadString(
                                                                            "State_names/State_names.json"),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                          .hasData) {
                                                                        if (snapshot.data !=
                                                                            null) {
                                                                          dynamic
                                                                              state_list =
                                                                              json.decode(snapshot.data.toString());
                                                                          return ListView.builder(
                                                                              itemCount: state_list?.length ?? 0,
                                                                              itemBuilder: (BuildContext context, int index) {
                                                                                return InkWell(
                                                                                  splashColor: Colors.blue,
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      selectedstate = state_list[index]["state"];
                                                                                      selectedstateindex = index;
                                                                                      Navigator.pop(context, selectedstate);
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                    width: MediaQuery.of(context).size.width,
                                                                                    height: MediaQuery.of(context).size.height * 0.07,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 10.0),
                                                                                      child: Row(
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            state_list[index]["state"],
                                                                                            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
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
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return Container(
                                                                            child:
                                                                                new Padding(padding: const EdgeInsets.all(5.0), child: new Center(child: new CircularProgressIndicator())));
                                                                      } else if (snapshot
                                                                          .hasError) {
                                                                        return new Text(
                                                                          '${snapshot.error}',
                                                                          style:
                                                                              TextStyle(color: Colors.red),
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
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                    decoration: BoxDecoration(
                                                        color: statevisible
                                                            ? Colors.red[400]
                                                            : Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            selectedstate,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'OpenSans',
                                                                fontSize: 15),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_drop_down_circle,
                                                            color: Colors.black,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        'Select District',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'openSans',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      districtvisible = false;
                                                    });
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      900],
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child:
                                                                    Scrollbar(
                                                                  child:
                                                                      FutureBuilder(
                                                                    future: DefaultAssetBundle.of(
                                                                            context)
                                                                        .loadString(
                                                                            "State_names/State_names.json"),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                          .hasData) {
                                                                        if (snapshot.data !=
                                                                            null) {
                                                                          dynamic
                                                                              district_list =
                                                                              json.decode(snapshot.data.toString());
                                                                          return selectedstate != 'Select state'
                                                                              ? ListView.builder(
                                                                                  itemCount: district_list[selectedstateindex]["districts"]?.length ?? 0,
                                                                                  itemBuilder: (BuildContext context, int index) {
                                                                                    return InkWell(
                                                                                      splashColor: Colors.blue,
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          selecteddistrict = district_list[selectedstateindex]["districts"][index];
                                                                                          Navigator.pop(context, selectedstate);
                                                                                        });
                                                                                      },
                                                                                      child: Container(
                                                                                        width: MediaQuery.of(context).size.width,
                                                                                        height: MediaQuery.of(context).size.height * 0.07,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.only(left: 10.0),
                                                                                          child: Row(
                                                                                            children: <Widget>[
                                                                                              Text(
                                                                                                district_list[selectedstateindex]["districts"][index],
                                                                                                style: TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
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
                                                                      } else if (snapshot
                                                                              .connectionState ==
                                                                          ConnectionState
                                                                              .waiting) {
                                                                        return Container(
                                                                            child:
                                                                                new Padding(padding: const EdgeInsets.all(5.0), child: new Center(child: new CircularProgressIndicator())));
                                                                      } else if (snapshot
                                                                          .hasError) {
                                                                        return new Text(
                                                                          '${snapshot.error}',
                                                                          style:
                                                                              TextStyle(color: Colors.red),
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
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                    decoration: BoxDecoration(
                                                        color: districtvisible
                                                            ? Colors.red[400]
                                                            : Colors.grey[200],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            selecteddistrict,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    'OpenSans',
                                                                fontSize: 15),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_drop_down_circle,
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
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        if (selectedstate ==
                                                            'Select state') {
                                                          setState(() {
                                                            statevisible = true;
                                                          });
                                                        }
                                                        if (selecteddistrict ==
                                                            'Select District') {
                                                          setState(() {
                                                            districtvisible =
                                                                true;
                                                          });
                                                        }

                                                        if (statevisible ==
                                                                false &&
                                                            districtvisible ==
                                                                false) {
                                                          setState(() {
                                                            isloading = true;
                                                          });

                                                          dynamic result = DatabaseService(
                                                                  uid: user.uid)
                                                              .UpdateUserDetails(
                                                                  userData.name,
                                                                  userData
                                                                      .phonenumber,
                                                                  userData
                                                                      .gender,
                                                                  userData.age,
                                                                  selectedstate,
                                                                  selectedstateindex,
                                                                  selecteddistrict,
                                                                  village,
                                                                  userData
                                                                      .image,
                                                                  userData
                                                                      .language,
                                                                  userData
                                                                      .languagecode);

                                                          //print(result.toString());

                                                          setState(() {
                                                            isloading = false;
                                                          });

                                                          print(isloading);
                                                          //Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("crop is added"),));
                                                          showLongToast();
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      child: Text(
                                                        'okay',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 18),
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
                                  color:kThemeColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        
                      ],
                    ),
>>>>>>> Stashed changes
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
