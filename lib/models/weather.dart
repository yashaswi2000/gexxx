

class CurrentWeatherData {
  final String timezone;
  final DateTime date;
  final double temp;
  final String main;
  final String description; 
  final double windspeed;
  final int humidity;
  final int pressure;
  

  CurrentWeatherData({this.timezone, this.date, this.temp, this.main, this.description, this.windspeed,this.humidity,this.pressure});
 

  /*factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      name: json['name'],
      temp: json['main']['temp'].toDouble(),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }*/
}

class DailyWeatherData {
final DateTime date;
final double temp;
final double windspeed;
final String main;
final String description;

  DailyWeatherData({this.date, this.temp, this.windspeed, this.main, this.description}); 
 
}