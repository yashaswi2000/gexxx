import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/models/weather.dart';
import 'package:gexxx_flutter/screens/Cropslist.dart';
import 'package:gexxx_flutter/screens/addcrop.dart';
import 'package:gexxx_flutter/screens/weatherpage.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:gexxx_flutter/database/database.dart';

import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  final User user;
  CurrentWeatherData currentWeatherData;
  List<DailyWeatherData> dailyweatherlist;
  bool loading;

  Home(
      {Key key,
      this.user,
      this.currentWeatherData,
      this.dailyweatherlist,
      this.loading})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  Map data;
  List CropData;
  String news = 'news';
  final translate = new GoogleTranslator();
  String selectedstate = 'Select state';
  String selecteddistrict = 'Select District';
  String village = '';
  bool isloading = false;
  Map weather;
  int selectedstateindex;
  bool isloadingweather = false;
  String latitude;
  String longitude;
  bool statevisible = false;
  bool districtvisible = false;
  bool locationerror = false;

  DateTime temp;
  Position userlocation;

  var stateController = new TextEditingController();
  var districtController = new TextEditingController();

  Future getData() async {
    http.Response response = await http.get(
        "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b&format=json&offset=0&limit=30");
    data = json.decode(response.body);
    //debugPrint(response.body);
    setState(() {
      CropData = data["records"];
    });
  }

  /* loadweather(double latitude, double longitude) async {
    var weatherResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&appid=a1cf1a893751e2ffb04008784ed48b00');

    if (weatherResponse.statusCode == 200) {
      weather = json.decode(weatherResponse.body);
      //print(weather);
      temp = DateTime.fromMillisecondsSinceEpoch(
          weather["current"]["dt"] * 1000,
          isUtc: false);
      setState(() {
        currentWeatherData = new CurrentWeatherData(
          date: temp,
          timezone: weather["timezone"],
          temp: weather["current"]["temp"],
          windspeed: weather["current"]["wind_speed"],
          main: weather["current"]["weather"][0]["main"],
          description: weather["current"]["weather"][0]["description"],
        );
      });
      for (var i = 0; i < weather["daily"].length; i++) {
        temp = DateTime.fromMillisecondsSinceEpoch(
            weather["daily"][i]["dt"] * 1000,
            isUtc: false);
        dailyWeatherData = new DailyWeatherData(
          date: temp,
          temp: weather["daily"][i]["temp"]["day"],
          windspeed: weather["daily"][i]["wind_speed"],
          main: weather["daily"][i]["weather"][0]["main"],
          description: weather["daily"][i]["weather"][0]["description"],
        );
        dailyweatherlist.add(dailyWeatherData);
        //print(dailyWeatherData.main);

      }
      print(dailyweatherlist);
    }
  }

  Future<Placemark> getPlacemark(double latitude, double longitude) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(latitude, longitude);
    return placemark[0];
  }

  Future<Position> _getCurrentLocation() async {
    var currentlocation;
    try {
      currentlocation = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      currentlocation = null;
    }

    return currentlocation;
  }*/

  Widget _village() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        onChanged: (val) {
          setState(() {
            village = val;
          });
        },
        validator: (val) => val.isEmpty ? 'Enter the village' : null,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.yellow,
          prefixIcon: Icon(Icons.landscape, color: Colors.black),
          border: InputBorder.none,
          hintText: 'village',
          hintStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontFamily: 'OpenSans'),
        ),
      ),
    );
  }

  /*void _getweather() async {
    _getCurrentLocation().then((position) {
      if (position != null) {
        setState(() {
          latitude = position.latitude.toString();
          longitude = position.longitude.toString();
          locationerror = false;
          getPlacemark(position.latitude, position.longitude).then((data) {
            loadweather(position.latitude, position.longitude);
            //print(weatherData);
          });
        });
      } else {
        setState(() {
          locationerror = true;
        });
      }
    });
  }
*/
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

  Future getlocation(String uid) async {
    bool temp = await DatabaseService(uid: uid).checklocation();
    if (mounted) {
      setState(() {
        islocation = temp;
      });
    }
  }

  void showLongToast() {
    Fluttertoast.showToast(
      msg: "Crop is added",
      toastLength: Toast.LENGTH_LONG,
    );
  }

  Widget _weather(CurrentWeatherData currentWeatherData) {
    print(currentWeatherData.temp);
    String temp = (currentWeatherData.temp - 273.15).toInt().toString();
    print('temp is $temp');

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.10,
        decoration: BoxDecoration(
            color: Colors.teal, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20.0, top: 20, bottom: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: AutoSizeText(
                  '$temp °C',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Circular',
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                  maxFontSize: 30,
                  minFontSize: 20,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Center(child: MyVerticalDivider()),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Center(
                  child: AutoSizeText(
                    '${currentWeatherData.main},${currentWeatherData.description}',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Circular',
                        fontWeight: FontWeight.normal,
                        fontSize: 20),
                    maxFontSize: 20,
                    minFontSize: 5,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Center(child: Icon(Icons.arrow_forward_ios)),
              )
            ],
          ),
        ));
  }

  String name = '';
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print('in home ${widget.loading}');
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
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
                        Row(
                          children: <Widget>[
                            AutoSizeText(
                              'WELCOME $name',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,color: Colors.teal),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: AutoSizeText(
                            'This is a agriculture based app ,which provides information about all the crops and you can add your intrested crops to get latest news etc',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.normal,
                            ),
                            maxFontSize: 15,
                            minFontSize: 13,
                          ),
                        ),
                        SizedBox(height: 20),
                        MyhorizontalDivider(),
                        InkWell(
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
                        ),
                        MyhorizontalDivider(),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            AutoSizeText(
                              'To add a crop press this button',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            FloatingActionButton.extended(
                              backgroundColor: Colors.teal,
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
                                  color: Colors.teal,
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
                              color: Colors.teal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
          } else if (snapshot.hasError) {
            return new Text(
              '${snapshot.error}',
              style: TextStyle(color: Colors.red),
            );
          }
          return Loading();
        });
  }
}
