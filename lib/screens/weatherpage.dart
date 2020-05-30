import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gexxx_flutter/models/weather.dart';

import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:gexxx_flutter/utilities/constants.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageScreenState createState() => _WeatherPageScreenState();
}

class _WeatherPageScreenState extends State<WeatherPage> {
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
                        : Colors.grey[900], borderRadius: BorderRadius.circular(5)),
        height: MediaQuery.of(context).size.height * 0.05,
       
        child: Padding(
          padding: const EdgeInsets.only(left:20.0,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                '${date.day} ${getmonth(date.month)}',
                style:
                    TextStyle( fontFamily: 'Circular'),
                
              ),
              AutoSizeText(
                '${dailyWeatherData.main}',
                style:
                    TextStyle( fontFamily: 'Circular'),
               
              ),
              Icon(
                Icons.details,
                
            
              ),
              AutoSizeText(
                '$temp°C',
                style: TextStyle(
                   
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.bold),
               
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
    _getweather();
  }

  @override
  Widget build(BuildContext context) {
    double value = (MediaQuery.of(context).size.height * 0.2);
    return currentWeatherData != null && dailyweatherlist.isNotEmpty
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
              appBar: AppBar(
                actions: <Widget>[],
                title: Text('Weather'),
                backgroundColor: kThemeColor,
              ),
              body: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                       
                      ),
                      child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              
                              AutoSizeText(
                                '${(currentWeatherData.temp - 273.15).toInt().toString()} °C',
                                style: TextStyle(
                                  
                                  fontFamily: 'Circular',
                                  fontWeight: FontWeight.normal,
                                ),
                                maxFontSize: 70,
                                minFontSize: 50,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            '${currentWeatherData.main} , ${currentWeatherData.description}',
                            style: TextStyle(
                            
                              fontFamily: 'Circular',
                              fontWeight: FontWeight.normal,
                            ),
                            maxFontSize: 30,
                            minFontSize: 20,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText(
                            '${DateTime.parse(currentWeatherData.date.toString()).day},${getmonth(DateTime.parse(currentWeatherData.date.toString()).month)},${DateTime.parse(currentWeatherData.date.toString()).year}',
                            style: TextStyle(
                             
                              fontFamily: 'Circular',
                              fontWeight: FontWeight.normal,
                            ),
                            maxFontSize: 20,
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left:10.0,right: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),boxShadow: [BoxShadow(color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[200]
                        : Colors.black,spreadRadius: 2,blurRadius: 4)]),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.ac_unit,color: Colors.black,),
                                   AutoSizeText(
                                    '${currentWeatherData.humidity.toString()}%',
                                    style: TextStyle(
                                        fontFamily: 'Circular',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    maxLines: 1,
                                    minFontSize: 20,
                                    maxFontSize: 20,
                                  ),
                                  AutoSizeText(
                                    'HUMIDITY',
                                    style: TextStyle(
                                        fontFamily: 'Circular',
                                        color: Colors.black,
                                        fontWeight:
                                            FontWeight.w500,
                                        fontSize: 10),
                                    maxLines: 1,
                                    minFontSize: 10,
                                    maxFontSize: 10,
                                  ),
                                 
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                 
                                  Icon(
                                    Icons.label_outline,
                                    color: Colors.black,
                                  ),
                                  
                                  AutoSizeText(
                                    '${currentWeatherData.windspeed.toString()}m/s',
                                    style: TextStyle(
                                        fontFamily: 'Circular',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    maxLines: 1,
                                    minFontSize: 20,
                                    maxFontSize: 20,
                                  ),
                                  AutoSizeText(
                                    'WIND',
                                    style: TextStyle(
                                        fontFamily: 'Circular',
                                        color: Colors.black,
                                        fontWeight:
                                            FontWeight.w500,
                                        fontSize: 10),
                                    maxLines: 1,
                                    minFontSize: 10,
                                    maxFontSize: 10,
                                  ),
                                  
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                 
                                  Icon(
                                   Icons.timelapse,
                                    color: Colors.black,
                                  ),
                                  
                                  AutoSizeText(
                                    '${currentWeatherData.pressure.toString()}hpa',
                                    style: TextStyle(
                                        fontFamily: 'Circular',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    maxLines: 1,
                                    minFontSize: 20,
                                    maxFontSize: 20,
                                  ),
                                  AutoSizeText(
                                    'PRESSURE',
                                    style: TextStyle(
                                        fontFamily: 'Circular',
                                        color: Colors.black,
                                        fontWeight:
                                            FontWeight.normal,
                                        fontSize: 10),
                                    maxLines: 1,
                                    minFontSize: 10,
                                    maxFontSize: 10,
                                  ),
                                 
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Expanded(
                     
                      child: ListView.builder(
                          itemCount: dailyweatherlist?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return dailyweatherbox(
                                dailyweatherlist[index]);
                          }),
                    ),
                  
                    MyhorizontalDivider(),
                    SizedBox(height: 20,)
                   
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
            body: Center(child: CircularProgressIndicator()));
  }
}
