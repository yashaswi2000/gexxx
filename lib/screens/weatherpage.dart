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

  Widget dailyweatherbox(DailyWeatherData dailyWeatherData){
    var date = DateTime.parse(dailyWeatherData.date.toString());
  String temp = (dailyWeatherData.temp - 273.15).toInt().toString();

    return Padding(
      padding: const EdgeInsets.only(left:20.0,right:20,top:10,bottom:10),
      child: Container(
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
      
        height: MediaQuery.of(context).size.height*0.05,
        child: Padding(
          padding: const EdgeInsets.only(left:15.0,right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
               
                height: 30,
                width: MediaQuery.of(context).size.width*0.18,
                child: Center(
                  child: AutoSizeText(
                    '${date.day} ${getmonth(date.month)}',
                    style: TextStyle(color: Colors.black,fontFamily: 'Circular'),
                    maxLines: 1,
                    minFontSize: 18,
                    maxFontSize: 30,
                    
                  ),
                ),
              ),Container(
                height: 30,
                width: MediaQuery.of(context).size.width*0.18,
                child: Center(
                                              child: AutoSizeText(
                    '${dailyWeatherData.main}',
                    style: TextStyle(color: Colors.black,fontFamily: 'Circular'),
                    maxLines: 1,
                    minFontSize: 18,
                    maxFontSize: 30,
                    
                  ),
                ),
              ),
              Container(
                
                height: 30,
                width: MediaQuery.of(context).size.width*0.18,
                child: Center(child: Icon(Icons.details,color: Colors.black,size: 35,))
              ),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width*0.18,
                child: Center(
                  child: AutoSizeText(
                    '$temp°C',
                    style: TextStyle(color: Colors.black,fontFamily: 'Circular',fontWeight: FontWeight.bold),
                    maxLines: 1,
                    minFontSize: 25,
                    maxFontSize: 30,
                    
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
  String getmonth(int value)
    {
      if(value==1)
      {
        return 'January';
      }
      if(value==2)
      {
        return 'February';
      }
      if(value==3)
      {
        return 'March';
      }
      if(value==4)
      {
        return 'April';
      }
      if(value==5)
      {
        return 'May';
      }
      if(value==6)
      {
        return 'June';
      }
      if(value==7)
      {
        return 'July';
      }
      if(value==8)
      {
        return 'August';
      }
      if(value==9)
      {
        return 'September';
      }
      if(value==10)
      {
        return 'October';
      }
      if(value==11)
      {
        return 'Novembeer';
      }
      if(value==12)
      {
        return 'December';
      }
    }
  @override
  Widget build(BuildContext context) {
    String temp = (widget.currentWeatherData.temp - 273.15).toInt().toString();
    var date = DateTime.parse(widget.currentWeatherData.date.toString());
    double value = (MediaQuery.of(context).size.height * 0.2);
    // TODO: implement build
    String image='';

    

    if(widget.currentWeatherData.main=='Thunderstorm')
    {
      setState(() {
        image = 'assets/images/thunderstrom.png';
      });
    }
    
    else if(widget.currentWeatherData.main=='Rain')
    {
      setState(() {
        image = 'assets/images/rain.png';
      });
    }
    
    else if(widget.currentWeatherData.main=='Smoke')
    {
      setState(() {
        image = 'assets/images/smoke.png';
      });
    }
    
    else if(widget.currentWeatherData.main=='Haze')
    {
      setState(() {
        image = 'assets/images/haze.png';
      });
    }
    
   else  if(widget.currentWeatherData.main=='Dust')
    {
      setState(() {
        image = 'assets/images/dust.png';
      });
    }
    
    else if(widget.currentWeatherData.main=='Fog')
    {
      setState(() {
        image = 'assets/images/Smoke.png';
      });
    }
    
    else if(widget.currentWeatherData.main=='Clear')
    {
      setState(() {
        image = 'assets/images/clearsky.png';
      });
    }
    
    else if(widget.currentWeatherData.main=='Sand')
    {
      setState(() {
        image = 'assets/images/sand.png';
      });
    }
     else if(widget.currentWeatherData.main=='Clouds')
    {
      setState(() {
        image = 'assets/images/cloudy.png';
      });
    }
    else{
      setState(() {
        image = 'assets/images/cloudy.png';
      });
    }
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
                  decoration: BoxDecoration(color: Colors.black,image:DecorationImage(image: 
                  
                  AssetImage(image),fit: BoxFit.cover)),
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
                          WeatherIcons.thermometer,
                          size: 30,
                        ),
                        
                        SizedBox(
                          width: temp.length.toDouble() * 80,
                          child: Center(
                            child: AutoSizeText(
                              '$temp °C',
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
                      width: widget.currentWeatherData.description.length
                              .toDouble() *
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
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width:MediaQuery.of(context).size.width*0.5,
                      child: Center(
                        child: AutoSizeText(
                          '${date.day},${getmonth(date.month)},${date.year}',
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
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 220),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: Column(
                                children: <Widget>[
                                  Expanded(child: Container(),),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: 25,
                                    child: Center(
                                      child: Icon(
                                        WeatherIcons.humidity,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    height: 25,
                                    child: Center(
                                      child: AutoSizeText(
                                        '${widget.currentWeatherData.humidity.toString()}%',
                                        style: TextStyle(
                                            fontFamily: 'Circular',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,fontSize: 20),
                                        maxLines: 1,
                                        minFontSize: 20,
                                        maxFontSize: 40,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: 10,
                                    child: Center(
                                      child: AutoSizeText(
                                        'HUMIDITY',
                                        style: TextStyle(
                                            fontFamily: 'Circular',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,fontSize: 10),
                                        maxLines: 1,
                                        minFontSize: 10,
                                        maxFontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Container(),),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                children: <Widget>[
                                  Expanded(child: Container(),),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: 25,
                                    child: Center(
                                      child: Icon(
                                        WeatherIcons.windy,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.19,
                                    height: 25,
                                    child: Center(
                                      child: AutoSizeText(
                                        '${widget.currentWeatherData.windspeed.toString()}m/s',
                                        style: TextStyle(
                                            fontFamily: 'Circular',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,fontSize: 20),
                                        maxLines: 1,
                                        minFontSize: 20,
                                        maxFontSize: 40,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                        height: 10,
                                    child: Center(
                                      child: AutoSizeText(
                                        'WIND',
                                        style: TextStyle(
                                            fontFamily: 'Circular',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,fontSize: 10),
                                        maxLines: 1,
                                        minFontSize: 10,
                                        maxFontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Container(),),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                children: <Widget>[
                                  Expanded(child: Container(),),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    height: 25,
                                    child: Center(
                                      child: Icon(
                                        WeatherIcons.time_1,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.19,
                                    height: 25,
                                    child: Center(
                                      child: AutoSizeText(
                                        '${widget.currentWeatherData.pressure.toString()}hpa',
                                        style: TextStyle(
                                            fontFamily: 'Circular',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,fontSize: 20),
                                        maxLines: 1,
                                        minFontSize: 20,
                                        maxFontSize: 40,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                        height: 10,
                                    child: Center(
                                      child: AutoSizeText(
                                        'PRESSURE',
                                        style: TextStyle(
                                            fontFamily: 'Circular',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,fontSize: 10),
                                        maxLines: 1,
                                        minFontSize: 10,
                                        maxFontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(child: Container(),),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:370.0,left:10,right: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    decoration: BoxDecoration(color: Colors.teal),
                    child: ListView.builder(
                      itemCount: widget.dailyWeatherlist?.length??0,
                      itemBuilder: (BuildContext context , int index){
                        return 
                        dailyweatherbox(widget.dailyWeatherlist[index]);
                      }),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top:700.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.6,
                   
                    child:Center(child: Text('footer')),
                  ),
                ),
                

              ],
            ),
          ],
        ),
      ),
    );
  }
}
