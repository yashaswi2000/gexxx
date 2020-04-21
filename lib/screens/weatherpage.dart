import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gexxx_flutter/models/weather.dart';
import 'package:gexxx_flutter/utilities/MyhorizantalDivider.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherPage extends StatefulWidget {
  final CurrentWeatherData currentWeatherData;
  final List<DailyWeatherData> dailyWeatherlist;

  const WeatherPage({Key key, this.currentWeatherData, this.dailyWeatherlist})
      : super(key: key);
  @override
  _WeatherPageScreenState createState() => _WeatherPageScreenState();
}

class _WeatherPageScreenState extends State<WeatherPage> {
  String temp = '33 °C';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[],
        title: Text('Weather'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(color: Colors.black),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          WeatherIcons.cloudy,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: temp.length.toDouble() * 30,
                          child: Center(
                            child: AutoSizeText(
                              temp,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Circular',
                                fontWeight: FontWeight.normal,
                              ),
                              maxFontSize: 70,
                              minFontSize: 50,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width:
                          widget.currentWeatherData.description.length.toDouble() *
                              30,
                      child: Center(
                        child: AutoSizeText(
                          '${widget.currentWeatherData.main} , ${widget.currentWeatherData.description}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Circular',
                            fontWeight: FontWeight.normal,
                          ),
                          maxFontSize: 30,
                          minFontSize: 20,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width:
                          widget.currentWeatherData.description.length.toDouble() *
                              30,
                      child: Center(
                        child: AutoSizeText(
                          widget.currentWeatherData.date.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Circular',
                            fontWeight: FontWeight.normal,
                          ),
                          maxFontSize: 20,
                          minFontSize: 10,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left:10.0,right: 10,top:220),
                  child: Center(
                                  child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: MediaQuery.of(context).size.height*0.15,
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
