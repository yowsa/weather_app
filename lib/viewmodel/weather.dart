import 'package:flutter/material.dart';

import 'date_helper.dart';
import 'weather_icons.dart';
import 'weather_calculator.dart';

class CurrentWeather {
  String location;
  String dateTime;
  int humidity;
  num temperature;
  String description;
  IconData icon;

  CurrentWeather(
      {this.location,
      this.dateTime,
      this.humidity,
      this.temperature,
      this.description,
      this.icon});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    String date = DateHelper.localFormatDate(json['timezone'], json['dt'],
        dateFormat: 'H:m EEEE, d MMM');
    return CurrentWeather(
        humidity: json['main']['humidity'],
        location: json['name'],
        temperature: json['main']['temp'],
        description: json['weather'][0]['description'],
        icon: WeatherIcons.icon(json['weather'][0]['icon']),
        dateTime: date);
  }
}

class FiveDayForecast {
  List<ForecastDay> forecast;
  ForecastDay todayForecast;

  FiveDayForecast({this.forecast, this.todayForecast});

  factory FiveDayForecast.fromJson(Map<String, dynamic> json) {
    var fiveDayThreeHourData = json['list'] != null
        ? (json['list'] as List)
            .map((i) => ThreeHourForecast.fromJson(i))
            .toList()
        : null;
    ForecastResult dailyForecast = ForecastCalculator()
        .getForecast(fiveDayThreeHourData, json['city']['timezone']);
    return FiveDayForecast(
      forecast: json['list'] != null ? dailyForecast.fiveDayForecast : [],
      todayForecast: json['list'] != null ? dailyForecast.todayForecast : [],
    );
  }
}

class ThreeHourForecast {
  int timestamp;
  String dtTxt;
  num temperature;
  String description;
  IconData icon;

  ThreeHourForecast(
      {this.timestamp,
      this.dtTxt,
      this.temperature,
      this.description,
      this.icon});

  factory ThreeHourForecast.fromJson(Map<String, dynamic> json) {
    return ThreeHourForecast(
      timestamp: json['dt'],
      description: json['weather'][0]['description'],
      icon: WeatherIcons.icon(json['weather'][0]['icon']),
      temperature: json['main']['temp'],
      dtTxt: json['dt_txt'],
    );
  }
}



