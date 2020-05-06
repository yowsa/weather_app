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

  void _fetchNewData() {
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
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.white,
          backgroundColor: Colors.grey[400],
          accentColor: Colors.black,
          fontFamily: 'Roboto'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh, size: 30.0),
            onPressed: _fetchNewData,
            )
          ],
        ),
        body: Center(
          child: FutureBuilder<AllWeatherData>(
            future: allWeatherData,
            builder: (context, AsyncSnapshot<AllWeatherData> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(snapshot.data.currentWeather.name
                                    .toUpperCase(), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                                Text(snapshot.data.currentWeather.dateTime.toUpperCase()),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Icon(
                                  snapshot.data.currentWeather.weather[0].icon,
                                  size: 60.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(snapshot
                                      .data.currentWeather.weather[0].description
                                      .toUpperCase()),
                                ),
                              ],
                            ),
                            Text(
                              '${snapshot.data.currentWeather.main.temp.round()}°C',
                              style: TextStyle(fontSize: 100.0),
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
                                        color: Theme.of(context).primaryColor)),
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
                                        color: Theme.of(context).primaryColor)),
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
                    ),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      alignment: Alignment.bottomCenter,
                      height: 132,
                      child: Image(
                        width: MediaQuery.of(context).size.width,
                        image: AssetImage('assets/london_transparent.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9.0, right: 8.0),
                      child: Container(
                        color: Theme.of(context).accentColor,
                        height: 250,
//                      width: 100,
                        child: ListView.separated(
                            separatorBuilder: (BuildContext context, int index) =>
                                Divider(
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
                                          size: 30.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                                          child: Container(
                                              width: 40.0,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  '${snapshot.data.fiveDayForecast.forecast[index].tempMax.round()}°C')),
                                        ),
                                        Container(
                                            height: 20,
                                            width: 10.0,
                                            alignment: Alignment.centerRight,
                                            child: VerticalDivider(
                                                color: Theme.of(context).primaryColor)),
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
                      ),
                    ),
                  ],
                );
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
