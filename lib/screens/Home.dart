import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gexxx_flutter/app_localizations.dart';
import 'package:gexxx_flutter/main.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/models/weather.dart';
import 'package:gexxx_flutter/screens/Cropslist.dart';
import 'package:gexxx_flutter/screens/Languagepage.dart';
import 'package:gexxx_flutter/screens/MainDrawer.dart';
import 'package:gexxx_flutter/screens/News.dart';
import 'package:gexxx_flutter/screens/Policies.dart';
import 'package:gexxx_flutter/screens/addcrop.dart';
import 'package:gexxx_flutter/screens/cropplan.dart';
import 'package:gexxx_flutter/screens/marketiew.dart';
import 'package:gexxx_flutter/screens/weatherpage.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/Loading.dart';
import 'package:gexxx_flutter/utilities/MyVerticalDivider.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:gexxx_flutter/utilities/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:gexxx_flutter/database/database.dart';
import 'package:image/image.dart' as ImD;
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:translator/translator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_icons/weather_icons.dart';
import 'dart:ui' as ui;

class Home extends StatefulWidget {
  final UserData userData;
  CurrentWeatherData currentWeatherData;
  List<DailyWeatherData> dailyweatherlist;
  bool loading;

  Home({
    Key key,
    this.userData,
  }) : super(key: key);

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
  int selectedstateindex;
  bool isloadingweather = false;
  bool statevisible = false;
  bool districtvisible = false;

  var stateController = new TextEditingController();
  var districtController = new TextEditingController();
  File image;
  Future getData() async {
    http.Response response = await http.get(
        "https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b&format=json&offset=0&limit=30");
    data = json.decode(response.body);
    //debugPrint(response.body);
    setState(() {
      CropData = data["records"];
    });
  }

  Map weather;

  String latitude;
  String longitude;

  bool locationerror = false;

  CurrentWeatherData currentWeatherData;
  DailyWeatherData dailyWeatherData;
  List<DailyWeatherData> dailyweatherlist = [];
  DateTime temp;
  Position userlocation;

  loadweather(double latitude, double longitude) async {
    var weatherResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&appid=a1cf1a893751e2ffb04008784ed48b00');
    print(weatherResponse.statusCode);
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
          humidity: weather["current"]["humidity"],
          pressure: weather["current"]["pressure"],
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
      }
      //print(currentWeatherData.humidity);
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
  }

  String sublocality;
  String locality;
  String country;
  Future<bool> _getweather() async {
    _getCurrentLocation().then((position) {
      if (position != null) {
        getPlacemark(position.latitude, position.longitude).then((data) {
          setState(() {
            locality = data.locality;
            country = data.country;
            sublocality = data.subLocality;
          });
          loadweather(position.latitude, position.longitude);
          return true;
        });
        return true;
      } else {
        setState(() {
          locationerror = true;
        });
        return false;
      }
    });
  }

  Widget dailyweatherbox(DailyWeatherData dailyWeatherData) {
    var date = DateTime.parse(dailyWeatherData.date.toString());
    String temp = (dailyWeatherData.temp - 273.15).toInt().toString();

    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey[200]
                : Colors.grey[900],
            borderRadius: BorderRadius.circular(5)),
        height: MediaQuery.of(context).size.height * 0.05,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                '${date.day} ${getmonth(date.month)}',
                style: TextStyle(fontFamily: 'Circular'),
              ),
              AutoSizeText(
                '${dailyWeatherData.main}',
                style: TextStyle(fontFamily: 'Circular'),
              ),
              Icon(
                Icons.details,
              ),
              AutoSizeText(
                '$temp°C',
                style: TextStyle(
                    fontFamily: 'Circular', fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getmonth(int value) {
    if (value == 1) {
      return 'January';
    }
    if (value == 2) {
      return 'February';
    }
    if (value == 3) {
      return 'March';
    }
    if (value == 4) {
      return 'April';
    }
    if (value == 5) {
      return 'May';
    }
    if (value == 6) {
      return 'June';
    }
    if (value == 7) {
      return 'July';
    }
    if (value == 8) {
      return 'August';
    }
    if (value == 9) {
      return 'September';
    }
    if (value == 10) {
      return 'October';
    }
    if (value == 11) {
      return 'November';
    }
    if (value == 12) {
      return 'December';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = 0;
    pageController = PageController(initialPage: 0);
    _getweather();
  }

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

  bool islocation = false;

  Future getlocation(String uid) async {
    bool temp = await DatabaseService(uid: uid).checklocation();
    if (mounted) {
      setState(() {
        islocation = temp;
      });
    }
  }

  void showLongToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  Widget favouritecrops() {
    return InkWell(
      onTap: () {},
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

  Widget ActionCard(
      String title, IconData icon, Color color, Function onPressed) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed,
      child: Ink(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.23,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
                blurRadius: 5,
                spreadRadius: 1,
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
              style:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  String name = '';
  final AuthService _auth = AuthService();
  PageController pageController;
  String selectedcrop = '';

  int selectedRadio;

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  List<String> croplist = [];

  Widget _customtextbox(String title, Function onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pricebox(DocumentSnapshot snapshot) {
    print(int.parse(snapshot['pricelist'][0]['market_list'][0]['timestamp']));
    int day = DateTime.fromMillisecondsSinceEpoch((int.parse(
                snapshot['pricelist'][0]['market_list'][0]['timestamp'])) *
            1000)
        .day;
    int year = DateTime.fromMillisecondsSinceEpoch((int.parse(
                snapshot['pricelist'][0]['market_list'][0]['timestamp'])) *
            1000)
        .year;
    int month = DateTime.fromMillisecondsSinceEpoch((int.parse(
                snapshot['pricelist'][0]['market_list'][0]['timestamp'])) *
            1000)
        .month;
    int percentage = 0;
    Color c = Colors.grey[200];
    int size = snapshot['pricelist'][0]['market_list'].length;
    if (size > 1) {
      int diff = snapshot['pricelist'][0]['market_list'][size]['modal_price'] -
          snapshot['pricelist'][0]['market_list'][size - 1]['modal_price'];

      percentage = ((diff /
              snapshot['pricelist'][0]['market_list'][size - 1]['modal_price']))
          .toInt();
      if (diff >= 0) {
        c = Colors.red;
      } else {
        c = Colors.red;
      }
    }
    return snapshot.data.isNotEmpty
        ? InkWell(
            child: Container(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          snapshot['commodity'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018),
                        ),
                        Text(
                          '₹ ${snapshot['pricelist'][0]['market_list'][0]['modal_price']}/-',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot['pricelist'][0]['market'],
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${day}-${month}-${year}',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: c,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 10, bottom: 10),
                            child: Text(
                              percentage.toString(),
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.017),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _marketview(List<DocumentSnapshot> snapshots) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => marketview(
                      snapshots: snapshots,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: Colors.grey[200], spreadRadius: 1, blurRadius: 5)
            ]),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Market view',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                _pricebox(snapshots[0]),
                _pricebox(snapshots[1]),
                _pricebox(snapshots[2]),
              ],
            )
          ],
        ),
      ),
    );
  }

  List RGBAList;

  Future _pickimage() async {
    var i = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 150,
        maxWidth: 150);
    setState(() {
      image = i;
    });

    String bas64 = base64Encode(i.readAsBytesSync());
    print(bas64);
    ui.Image decodeimage = await decodeImageFromList(image.readAsBytesSync());

    decodeimage
        .toByteData(format: ui.ImageByteFormat.rawRgba)
        .then((ByteData data) {
      setState(() {
        RGBAList = data.buffer.asUint8List().toList();
      });
    });
    //print(RGBAList.length);
    //print(image);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    List<Widget> circle = [];

    return PageView(
      controller: pageController,
      children: <Widget>[
        StreamBuilder<Object>(
            stream: DatabaseService().market,
            builder: (context, msnapshot) {
              if (msnapshot.hasData) {
                List<DocumentSnapshot> dsnapshot = msnapshot.data;
                return Scaffold(
                    backgroundColor: Colors.white,
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "GEXXX",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.navigate_next,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      pageController.nextPage(
                                          duration: Duration(microseconds: 700),
                                          curve: Curves.easeIn);
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('Dashboard'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                        ),
                                        Text(
                                          widget.userData.name,
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w400,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                        ),
                                      ],
                                    ),
                                    currentWeatherData == null ||
                                            locality == null ||
                                            country == null
                                        ? Shimmer.fromColors(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              color: Colors.grey[200],
                                            ),
                                            baseColor: Colors.grey[300],
                                            highlightColor: Colors.white)
                                        : Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.wb_cloudy,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${(currentWeatherData.temp - 273.15).toInt().toString()}°C',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.065),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '${locality},${country}',
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03),
                                                ),
                                              ],
                                            ),
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  runSpacing: 20,
                                  spacing: 20,
                                  children: <Widget>[
                                    ActionCard(
                                        AppLocalizations.of(context)
                                            .translate('All Crops'),
                                        Icons.tab,
                                        Colors.blue, () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Cropslist()));
                                    }),
                                    ActionCard(
                                        AppLocalizations.of(context)
                                            .translate('Policies'),
                                        Icons.panorama_wide_angle,
                                        Colors.red, () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Policies()));
                                    }),
                                    ActionCard(
                                        AppLocalizations.of(context)
                                            .translate('News'),
                                        Icons.public,
                                        kThemeColor, () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => News(),
                                          ));
                                    }),
                                    ActionCard(
                                        AppLocalizations.of(context)
                                            .translate('Weather'),
                                        WeatherIcons.day_sunny,
                                        kThemeColor, () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WeatherPage(
                                                    currentWeatherData:
                                                        currentWeatherData,
                                                    dailyweather:
                                                        dailyweatherlist,
                                                  )));
                                    }),
                                    ActionCard(
                                        AppLocalizations.of(context)
                                            .translate('About us'),
                                        Icons.priority_high,
                                        Colors.red,
                                        () async {}),
                                    ActionCard(
                                        AppLocalizations.of(context)
                                            .translate('Logout'),
                                        Icons.power_settings_new,
                                        kThemeColor, () {
                                      AuthService().signoutwithGoogle();
                                    }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Cropplan(
                                              userData: widget.userData)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10,
                                        top: 20,
                                        bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.playlist_add_check,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Crop Plan',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.navigate_next,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /*InkWell(
                              onTap: () {
                                _pickimage();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10,
                                      top: 10,
                                      bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.playlist_add_check,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'pick image',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            image == null
                                ? Container()
                                : Center(child: Image.file(image)),*/
                              SizedBox(
                                height: 10,
                              ),
                              _marketview(dsnapshot),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              } else {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            }),
        Scaffold(
          backgroundColor: Colors.grey[200],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        AppLocalizations.of(context)
                            .translate('Your Favourites'),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 30, bottom: 30),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 20,
                        runSpacing: 20,
                        children: circle,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      //height: MediaQuery.of(context).size.height * 0.2,
                      //width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[200],
                                spreadRadius: 1,
                                blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _customtextbox(
                              AppLocalizations.of(context)
                                  .translate('Your orders'),
                              () {}),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Divider(
                              color: Colors.grey[700],
                              height: 5,
                            ),
                          ),
                          _customtextbox(
                              AppLocalizations.of(context)
                                  .translate('Your Account'),
                              () {}),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Divider(
                              color: Colors.grey[700],
                              height: 5,
                            ),
                          ),
                          _customtextbox(
                              AppLocalizations.of(context)
                                  .translate('Your Whishlist'),
                              () {}),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Divider(
                              color: Colors.grey[700],
                              height: 5,
                            ),
                          ),
                          _customtextbox(
                              AppLocalizations.of(context)
                                  .translate('Change Phone number'),
                              () {}),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Divider(
                              color: Colors.grey[700],
                              height: 5,
                            ),
                          ),
                          _customtextbox(
                              AppLocalizations.of(context)
                                  .translate('Address Book'),
                              () {}),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Divider(
                              color: Colors.grey[700],
                              height: 5,
                            ),
                          ),
                          _customtextbox(
                              AppLocalizations.of(context)
                                  .translate('settings'),
                              () {}),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Divider(
                              color: Colors.grey[700],
                              height: 5,
                            ),
                          ),
                          _customtextbox(
                              AppLocalizations.of(context)
                                  .translate('languages'), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LanguagePage()));
                          })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
