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
  List<DailyWeatherData> dailyweather;
  CurrentWeatherData currentWeatherData;
  WeatherPage({this.dailyweather, this.currentWeatherData});
  @override
  _WeatherPageScreenState createState() => _WeatherPageScreenState();
}

class _WeatherPageScreenState extends State<WeatherPage> {
  Widget dailyweatherbox(DailyWeatherData dailyWeatherData) {
    var date = DateTime.parse(dailyWeatherData.date.toString());
    String temp = (dailyWeatherData.temp - 273.15).toInt().toString();

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[900], borderRadius: BorderRadius.circular(5)),
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
  }

  @override
  Widget build(BuildContext context) {
    double value = (MediaQuery.of(context).size.height * 0.2);
    return widget.dailyweather == null
        ? Scaffold(
            backgroundColor: Colors.grey[200],
            body: SafeArea(
              child: Center(
                child: Text(
                  'error getting data',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.grey[200],
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AutoSizeText(
                                  '${(widget.currentWeatherData.temp - 273.15).toInt().toString()} °C',
                                  style: TextStyle(
                                    color: Colors.black,
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
                              '${widget.currentWeatherData.main} , ${widget.currentWeatherData.description}',
                              style: TextStyle(
                                color: Colors.black,
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
                              '${DateTime.parse(widget.currentWeatherData.date.toString()).day},${getmonth(DateTime.parse(widget.currentWeatherData.date.toString()).month)},${DateTime.parse(widget.currentWeatherData.date.toString()).year}',
                              style: TextStyle(
                                color: Colors.black,
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
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[200],
                                  spreadRadius: 2,
                                  blurRadius: 4)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.ac_unit,
                                    color: Colors.black,
                                  ),
                                  AutoSizeText(
                                    '${widget.currentWeatherData.humidity.toString()}%',
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
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                    maxLines: 1,
                                    minFontSize: 10,
                                    maxFontSize: 10,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.label_outline,
                                    color: Colors.black,
                                  ),
                                  AutoSizeText(
                                    '${widget.currentWeatherData.windspeed.toString()}m/s',
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
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                    maxLines: 1,
                                    minFontSize: 10,
                                    maxFontSize: 10,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.timelapse,
                                    color: Colors.black,
                                  ),
                                  AutoSizeText(
                                    '${widget.currentWeatherData.pressure.toString()}hpa',
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
                                        fontWeight: FontWeight.normal,
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
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.dailyweather?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return dailyweatherbox(widget.dailyweather[index]);
                        }),
                    MyhorizontalDivider(),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
