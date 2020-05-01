import 'dart:async';
import 'package:flutter/material.dart';

import 'viewmodel/weather_data.dart' as weather_data;
import 'viewmodel/weather.dart' as weather;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<weather.WeatherToday> futureWeatherToday;
  Future<weather.WeatherFiveDayForecast> futureWeatherForecast;

  @override
  void initState() {
    super.initState();
    futureWeatherToday = weather_data.WeatherTodayData();
    futureWeatherForecast = weather_data.WeatherFiveDayForecastData();
    print(futureWeatherToday);
    futureWeatherToday.then((x) => print(x.name)).whenComplete(() => print("donnseee2"));
    futureWeatherForecast.then((x) => print("hello")).whenComplete(() => print("donnseee"));
//    print("hello");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<weather.WeatherToday>(
            future: futureWeatherToday,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.name);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
