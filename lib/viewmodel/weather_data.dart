import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'weather.dart';

class WeatherData {
  Future<CurrentWeather> currentWeatherData() async {
    // TODO: Update London, UK to id for accuracy
    // TODO: Move headers our to header parameter
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=9fbe123d1a4f8d4264364fe686406a3d&units=metric');

    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data for today');
    }
  }

  Future<FiveDayForecast> fiveDayForecastData() async {
    // TODO: Update London, UK to id for accuracy
    // TODO: Move headers our to header parameter
    final response = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?q=London,uk&appid=9fbe123d1a4f8d4264364fe686406a3d&units=metric');

    if (response.statusCode == 200) {
      return FiveDayForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather forecast');
    }
  }

  Future<AllWeatherData> getWeatherData() async {
    // TODO: Check if await prevents parallel calls, if so use Future<List<dynamic> varName = Future.wait(List<Future<dynamic>>)
    FiveDayForecast fiveDayForecast = await fiveDayForecastData();
    CurrentWeather currentWeather = await currentWeatherData();
    return AllWeatherData(currentWeather: currentWeather, fiveDayForecast: fiveDayForecast);
  }
}

class AllWeatherData{
  FiveDayForecast fiveDayForecast;
  CurrentWeather currentWeather;

  AllWeatherData({this.currentWeather, this.fiveDayForecast});
}
