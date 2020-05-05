import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weatherapp/viewmodel/weather_data.dart';
import 'package:weatherapp/presenter/weather_presenter.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UpdateWeather updateWeather = new UpdateWeather();
  Future<AllWeatherData> allWeatherData;

  @override
  void initState() {
    super.initState();
    allWeatherData = updateWeather.getWeatherData();
  }

  void _refresh() {
    setState(() {
      allWeatherData = updateWeather.getWeatherData();
      print("pressed a button");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
          brightness: Brightness.dark,
//          primarySwatch: Colors.grey,
          primaryColor: Colors.white,
//          textTheme: TextTheme(body1: TextStyle(color: Colors.white)),
          backgroundColor: Colors.grey[400],
          accentColor: Colors.black,
          fontFamily: 'Roboto'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FutureBuilder<AllWeatherData>(
                future: allWeatherData,
                builder: (context, AsyncSnapshot<AllWeatherData> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        Container(
                          color: Theme.of(context).backgroundColor,
                          child: Column(
                            children: <Widget>[
                              Text(snapshot.data.currentWeather.name
                                  .toUpperCase()),
                              Text(snapshot.data.currentWeather.dateTime),
                              Icon(
                                snapshot.data.currentWeather.weather[0].icon,
                                size: 60.0,
                              ),
                              Text(snapshot
                                  .data.currentWeather.weather[0].description
                                  .toUpperCase()),
                              Text(
                                '${snapshot.data.currentWeather.main.temp.round()}°C',
                                style: TextStyle(fontSize: 70.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text('HIGH'),
                                        Text(
                                            '${snapshot.data.fiveDayForecast.todayForecast.tempMax.round()}°C')
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 20,
                                      child: VerticalDivider(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text('LOW'),
                                        Text(
                                            '${snapshot.data.fiveDayForecast.todayForecast.tempMin.round()}°C')
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 20,
                                      child: VerticalDivider(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text('HUMIDITY'),
                                        Text(
                                            '${snapshot.data.currentWeather.main.humidity}%')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Theme.of(context).backgroundColor,
                          child: Image(
                            width: MediaQuery.of(context).size.width,
                            image: AssetImage('assets/london_transparent.png'),
                          ),
                        ),
                        Container(
                          color: Theme.of(context).accentColor,
                          child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) => Divider(
                                      height: 7,
                                      color: Theme.of(context).primaryColor),
                              itemCount:
                                  snapshot.data.fiveDayForecast.forecast.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  color: Theme.of(context).accentColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 50.0,
                                            child: Text(snapshot
                                                .data
                                                .fiveDayForecast
                                                .forecast[index]
                                                .weekday
                                                .toUpperCase()),
                                          ),
                                          Text(snapshot.data.fiveDayForecast
                                              .forecast[index].description
                                              .toUpperCase()),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            snapshot.data.fiveDayForecast
                                                .forecast[index].icon,
                                            color: Colors.green,
                                            size: 30.0,
                                          ),
//                                Text(snapshot.data.forecast[index].icon),
                                          Container(
                                              width: 40.0,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  '${snapshot.data.fiveDayForecast.forecast[index].tempMax.round()}°C')),
                                          Container(
                                              width: 40.0,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  '${snapshot.data.fiveDayForecast.forecast[index].tempMin.round()}°C')),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
              RaisedButton(
                onPressed: _refresh,
                child: Text("Update data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
