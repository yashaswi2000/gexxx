
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gexxx_flutter/database/database.dart';
import 'package:gexxx_flutter/models/user.dart';
import 'package:gexxx_flutter/models/weather.dart';
import 'package:gexxx_flutter/screens/Home.dart';
import 'package:gexxx_flutter/screens/MainDrawer.dart';
import 'package:gexxx_flutter/screens/UserpProfile.dart';
import 'package:gexxx_flutter/services/auth.dart';
import 'package:gexxx_flutter/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isloading = false;
  Map weather;
  bool isloadingweather = false;
  String latitude;
  String longitude;
  bool buttonpressed = false;
  bool locationerror = false;

  bool ackuserdata = false;
  bool ackcropdata = false;
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

  Future<bool> _getweather() async {
    _getCurrentLocation().then((position) {
      if (position != null) {
        setState(() {
          latitude = position.latitude.toString();
          longitude = position.longitude.toString();
          locationerror = false;
          getPlacemark(position.latitude, position.longitude).then((data) {
            loadweather(position.latitude, position.longitude);
            return true;
          });
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

  bool islocation = false;
  @override
  void initState() {
    super.initState();


   // _getweather();
  }

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }


  tabs(UserData userdata, int index) {
    if (index == 0) {
      return Home(
        userData: userdata,
      );
    }
    if (index == 1) {
      return Container();
    }
    if (index == 2) {
      return Container();
    }
    if (index == 3) {
      return Container();
    }
    if (index == 4) {
      return UserProfile(
        userData: userdata,
        
      );
    }
  }
  

  int CurrentIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          UserData userData =  snapshot.data;
          return Scaffold(
          appBar: AppBar(
            backgroundColor: kThemeColor,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.highlight_off),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
             
              
              IconButton(
                  icon: Icon(Theme.of(context).brightness == Brightness.light
                      ? Icons.lightbulb_outline
                      : Icons.highlight),
                  onPressed: () {
                    DynamicTheme.of(context).setBrightness(
                        Theme.of(context).brightness == Brightness.light
                            ? Brightness.dark
                            : Brightness.light);
                  })
            ],
            title: Text('GEXXX'),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 70.0,
            items: <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.event,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.event_note,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.call_split,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.perm_identity,
                size: 30,
                color: Colors.white,
              ),
            ],
            color: Colors.grey[800],
            buttonBackgroundColor: Colors.grey[800],
            backgroundColor: Colors.black,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                CurrentIndex = index;
              });
            },
          ),
          body: tabs(userData,CurrentIndex),
        );
        }
        else
        {
            return Container(child: Center(child: CircularProgressIndicator(),),);
        }
        
      }
    );
  }
}