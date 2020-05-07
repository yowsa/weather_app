import 'package:flutter/material.dart';
import 'date_helper.dart';

class CurrentWeather {
  int dt;
  int id;
  Main main;
  String name;
  int timezone;
  int visibility;
  List<Weather> weather;
  String dateTime;

  CurrentWeather(
      {this.dt,
      this.id,
      this.main,
      this.name,
      this.timezone,
      this.visibility,
      this.weather,
      this.dateTime});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    String date = DateHelper.localFormatDate(json['timezone'], json['dt'],
        dateFormat: 'H:m EEEE, d MMM');
    return CurrentWeather(
        dt: json['dt'],
        main: json['main'] != null ? Main.fromJson(json['main']) : null,
        name: json['name'],
        weather: json['weather'] != null
            ? (json['weather'] as List).map((i) => Weather.fromJson(i)).toList()
            : null,
        dateTime: date);
  }
}

class FiveDayForecast {
  CityDetails city;
  List<ForecastDay> forecast;
  ForecastDay todayForecast;

  FiveDayForecast({this.city, this.forecast, this.todayForecast});

  factory FiveDayForecast.fromJson(Map<String, dynamic> json) {
    var fiveDayThreeHourData = json['list'] != null
        ? (json['list'] as List)
            .map((i) => WeatherForecast.fromJson(i))
            .toList()
        : null;
    ForecastResult dailyForecast = ForecastCalculator()
        .getForecast(fiveDayThreeHourData, json['city']['timezone']);
    return FiveDayForecast(
      city: json['city'] != null ? CityDetails.fromJson(json['city']) : null,
      forecast: json['list'] != null ? dailyForecast.fiveDayForecast : [],
      todayForecast: json['list'] != null ? dailyForecast.todayForecast : [],
    );
  }
}

class Main {
  int humidity;
  num temp;

  Main({
    this.humidity,
    this.temp,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      humidity: json['humidity'],
      temp: json['temp'],
    );
  }
}

class Weather {
  String description;
  IconData icon;
  int id;
  String main;

  Weather({this.description, this.icon, this.id, this.main});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['description'],
      icon: WeatherIcons.icon(json['icon']),
      id: json['id'],
      main: json['main'],
    );
  }
}

class CityDetails {
  int timezone;

  CityDetails({this.timezone});

  factory CityDetails.fromJson(Map<String, dynamic> json) {
    return CityDetails(
      timezone: json['timezone'],
    );
  }
}

class WeatherForecast {
  int timestamp;
  Main mainWeatherData;
  List<Weather> weatherDescriptors;
  String dtTxt;

  WeatherForecast(
      {this.timestamp,
      this.mainWeatherData,
      this.weatherDescriptors,
      this.dtTxt});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      timestamp: json['dt'],
      mainWeatherData:
          json['main'] != null ? Main.fromJson(json['main']) : null,
      weatherDescriptors: json['weather'] != null
          ? (json['weather'] as List).map((i) => Weather.fromJson(i)).toList()
          : null,
      dtTxt: json['dt_txt'],
    );
  }
}

class WeatherIcons {
  static Map<String, dynamic> _icons = {
    "01d": Icons.brightness_5,
    "01n": Icons.brightness_4,
    "02d": Icons.brightness_6,
    "02n": Icons.brightness_6,
    "03d": Icons.filter_drama,
    "03n": Icons.filter_drama,
    "04d": Icons.cloud,
    "04n": Icons.cloud,
    "09d": Icons.grain,
    "09n": Icons.grain,
    "10d": Icons.grain,
    "10n": Icons.grain,
    "11d": Icons.flash_on,
    "11n": Icons.flash_on,
    "13d": Icons.ac_unit,
    "13n": Icons.ac_unit,
    "50d": Icons.dehaze,
    "50n": Icons.dehaze
  };

  static IconData icon(icon) {
    return _icons[icon];
  }
}

class ForecastDay {
  final String weekday;
  final num tempMax;
  final num tempMin;
  final String description;
  final IconData icon;
  final String date;

  ForecastDay(
      {this.weekday,
      this.tempMax,
      this.tempMin,
      this.description,
      this.icon,
      this.date});
}

class WeatherHelper {
  static Map<String, dynamic> getWeatherDescriptions(
      List fiveDayThreeHourData, int timezone) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    for (final threeHourSlot in fiveDayThreeHourData) {
      String date =
          DateHelper.localFormatDate(timezone, threeHourSlot.timestamp);
      int time = int.parse(DateHelper.localFormatDate(
          timezone, threeHourSlot.timestamp,
          dateFormat: "H"));
      int timeToNoon = (12 - time).abs();
      if (!data.containsKey(date)) {
        data[date] = {
          'timeToNoon': timeToNoon,
          'description': threeHourSlot.weatherDescriptors[0].description,
          'icon': threeHourSlot.weatherDescriptors[0].icon
        };
        continue;
      }
      if (timeToNoon < data[date]['timeToNoon']) {
        data[date] = {
          'timeToNoon': timeToNoon,
          'description': threeHourSlot.weatherDescriptors[0].description,
          'icon': threeHourSlot.weatherDescriptors[0].icon
        };
      }
    }
    return data;
  }
}

class ForecastResult {
  final ForecastDay todayForecast;
  final List<ForecastDay> fiveDayForecast;

  ForecastResult({this.todayForecast, this.fiveDayForecast});
}

class ForecastCalculator {
  Map<String, dynamic> _calculateDailyForecastDetails(
      List fiveDayThreeHourData, int timezone) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    for (final threeHourSlot in fiveDayThreeHourData) {
      String date =
          DateHelper.localFormatDate(timezone, threeHourSlot.timestamp);
      String weekday = DateHelper.localFormatDate(
          timezone, threeHourSlot.timestamp,
          dateFormat: 'E');

      if (!data.containsKey(date)) {
        data[date] = {
          'weekday': weekday,
          'tempMax': threeHourSlot.mainWeatherData.temp,
          'tempMin': threeHourSlot.mainWeatherData.temp
        };
        continue;
      }
      data[date] = {
        'weekday': weekday,
        'tempMax': threeHourSlot.mainWeatherData.temp > data[date]['tempMax']
            ? threeHourSlot.mainWeatherData.temp
            : data[date]['tempMax'],
        'tempMin': threeHourSlot.mainWeatherData.temp < data[date]['tempMin']
            ? threeHourSlot.mainWeatherData.temp
            : data[date]['tempMin'],
      };
    }
    return data;
  }

  ForecastResult _collateDailyForecastDetails(
      List fiveDayThreeHourData, Map dailyForecastDetails, int timezone) {
    Map data = dailyForecastDetails;

    var uniqueDates = data.keys.toList();
    Map weatherDescriptions =
        (WeatherHelper.getWeatherDescriptions(fiveDayThreeHourData, timezone));
    uniqueDates.sort();
    List<ForecastDay> forecastData = List<ForecastDay>();
    ForecastDay todayForecast;
    String today = DateHelper.getToday(timezone);
    for (final date in uniqueDates) {
      if (date == today) {
        todayForecast = ForecastDay(
            date: date,
            weekday: data[date]['weekday'],
            tempMax: data[date]['tempMax'],
            tempMin: data[date]['tempMin'],
            description: weatherDescriptions[date]['description'],
            icon: weatherDescriptions[date]['icon']);
      } else {
        forecastData.add(ForecastDay(
            date: date,
            weekday: data[date]['weekday'],
            tempMax: data[date]['tempMax'],
            tempMin: data[date]['tempMin'],
            description: weatherDescriptions[date]['description'],
            icon: weatherDescriptions[date]['icon']));
      }
    }

    return ForecastResult(
        todayForecast: todayForecast, fiveDayForecast: forecastData);
  }

  ForecastResult getForecast(List fiveDayThreeHourData, int timezone) {
    Map dailyForecastDetails =
        this._calculateDailyForecastDetails(fiveDayThreeHourData, timezone);
    ForecastResult forecast = this._collateDailyForecastDetails(
        fiveDayThreeHourData, dailyForecastDetails, timezone);
    return forecast;
  }
}
