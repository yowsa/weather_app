import 'dart:async';
import 'package:flutter/material.dart';

import 'viewmodel/weather_data.dart' as weather_data;
import 'viewmodel/weather_today.dart' as weather_today;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<weather_today.WeatherToday> futureWeatherToday;

  @override
  void initState() {
    super.initState();
    futureWeatherToday = weather_data.WeatherTodayData();
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
          child: FutureBuilder<weather_today.WeatherToday>(
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
