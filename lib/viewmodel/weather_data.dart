import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'weather.dart';


Future<WeatherToday> WeatherTodayData() async {
  // TODO: Update London, UK to id for accuracy
  // TODO: Move headers our to header parameter
  final response =
  await http.get('https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=9fbe123d1a4f8d4264364fe686406a3d');

  if (response.statusCode == 200) {
    return WeatherToday.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load weather data for today');
  }
}




Future<WeatherFiveDayForecast> WeatherFiveDayForecastData() async {
  // TODO: Update London, UK to id for accuracy
  // TODO: Move headers our to header parameter
  final response =
  await http.get('https://api.openweathermap.org/data/2.5/forecast?q=London,uk&appid=9fbe123d1a4f8d4264364fe686406a3d');

  if (response.statusCode == 200) {
    return WeatherFiveDayForecast.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load weather forecast');
  }
}

