import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weatherapp/viewmodel/weather.dart';
import 'package:weatherapp/presenter/weather_presenter.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<CurrentWeather> _currentWeather;
  Future<FiveDayForecast> _fiveDayForecast;
  UpdateWeather updateWeather = new UpdateWeather();


  @override
  void initState() {
    super.initState();
    _currentWeather = updateWeather.getWeatherToday();
    _fiveDayForecast = updateWeather.getWeatherForecast();
//    futureWeatherForecast.then((x) => print("hello")).whenComplete(() => print("donnseee"));
  }

  void _refresh() {
    setState(() {
      _currentWeather = updateWeather.getWeatherToday();
      _fiveDayForecast = updateWeather.getWeatherForecast();
      print("pressed a button");
    });
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
          child: Column(
            children: <Widget>[
            FutureBuilder<CurrentWeather>(
              future: _currentWeather,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.dt.toString());
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
               },
              ),
              FutureBuilder<FiveDayForecast>(
                future: _fiveDayForecast,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.city.name);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
              RaisedButton(onPressed: _refresh, child: Text("Update data"),)
            ],
          ),
        ),
      ),
    );
  }
}