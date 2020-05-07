import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:weatherapp/viewmodel/weather_data.dart';
import 'package:weatherapp/presenter/weather_presenter.dart';

class WeatherApp extends StatefulWidget {
  WeatherApp({Key key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  UpdateWeather updateWeather = new UpdateWeather();
  Future<AllWeatherData> allWeatherData;
  AllWeatherData latestWeatherData;

  @override
  void initState() {
    super.initState();
    _fetchNewData();
  }

  void _fetchNewData() {
    setState(() {
      allWeatherData = updateWeather.getWeatherData();
    });
    allWeatherData.then((weatherData) => latestWeatherData = weatherData)
        .catchError((a)  {
      Fluttertoast.showToast(
          msg: "Unable to fetch new data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }

  Widget currentWeather(context, AllWeatherData data) {
    return Expanded(
      child: Container(
        color: Theme
            .of(context)
            .backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  data.currentWeather.location.toUpperCase(),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(data.currentWeather.dateTime.toUpperCase()),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  data.currentWeather.icon,
                  size: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data.currentWeather.description.toUpperCase()),
                ),
              ],
            ),
            Text(
              '${data.currentWeather.temperature.round()}°C',
              style: TextStyle(
                  fontSize: MediaQuery
                      .of(context)
                      .size
                      .height * 0.09),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text('HIGH'),
                      Text(
                          '${data.fiveDayForecast.todayForecast.tempMax
                              .round()}°C')
                    ],
                  ),
                ),
                Container(
                    height: 20,
                    child:
                    VerticalDivider(color: Theme
                        .of(context)
                        .primaryColor)),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text('LOW'),
                      Text(
                          '${data.fiveDayForecast.todayForecast.tempMin
                              .round()}°C')
                    ],
                  ),
                ),
                Container(
                    height: 20,
                    child:
                    VerticalDivider(color: Theme
                        .of(context)
                        .primaryColor)),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    children: <Widget>[
                      Text('HUMIDITY'),
                      Text('${data.currentWeather.humidity}%')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget weatherForecast(context, AllWeatherData data) {
    return Container(
      color: Theme
          .of(context)
          .accentColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 9.0, right: 8.0),
        child: Container(
          color: Theme
              .of(context)
              .accentColor,
          height: 250,
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 7, color: Theme
                      .of(context)
                      .primaryColor),
              itemCount: data.fiveDayForecast.forecast.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Theme
                      .of(context)
                      .accentColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 50.0,
                            child: Text(data
                                .fiveDayForecast.forecast[index].weekday
                                .toUpperCase()),
                          ),
                          Text(data.fiveDayForecast.forecast[index].description
                              .toUpperCase()),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            data.fiveDayForecast.forecast[index].icon,
                            size: 30.0,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Container(
                                width: 40.0,
                                alignment: Alignment.centerRight,
                                child: Text(
                                    '${data.fiveDayForecast.forecast[index]
                                        .tempMax.round()}°C')),
                          ),
                          Container(
                              height: 20,
                              width: 10.0,
                              alignment: Alignment.centerRight,
                              child: VerticalDivider(
                                  color: Theme
                                      .of(context)
                                      .primaryColor)),
                          Container(
                              width: 40.0,
                              alignment: Alignment.centerRight,
                              child: Text(
                                  '${data.fiveDayForecast.forecast[index]
                                      .tempMin.round()}°C')),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget skyline(context) {
    return Container(
      color: Theme
          .of(context)
          .backgroundColor,
      alignment: Alignment.bottomCenter,
      height: 132,
      child: Image(
        width: MediaQuery
            .of(context)
            .size
            .width,
        image: AssetImage('assets/london_transparent.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey[400],
          primaryColor: Colors.white,
          backgroundColor: Colors.grey[400],
          accentColor: Colors.black,
          fontFamily: 'Roboto'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh, size: 30.0),
              onPressed: _fetchNewData,
            )
          ],
        ),
        body: Center(
          child: FutureBuilder<AllWeatherData>(
            future: allWeatherData,
            builder: (context, AsyncSnapshot<AllWeatherData> snapshot) {
              AllWeatherData data = snapshot.hasData
                  ? snapshot.data
                  : latestWeatherData;
              if (data != null) {
                return Column(
                  children: <Widget>[
                    currentWeather(context, data),
                    skyline(context),
                    weatherForecast(context, data),
                  ],
                );
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
