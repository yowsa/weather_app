import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrentWeather {
  int dt;
  int id;
  Main main;
  String name;
  Sys sys;
  int timezone;
  int visibility;
  List<Weather> weather;
  Wind wind;
  String dateTime;

  CurrentWeather(
      {this.dt,
      this.id,
      this.main,
      this.name,
      this.sys,
      this.timezone,
      this.visibility,
      this.weather,
      this.wind,
      this.dateTime});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    List dates = DateHelper.getDates(json['timezone'], json['dt'], dateFormat: 'H:m EEEE, d MMM');
//    print(dates[1]);
    return CurrentWeather(
      dt: json['dt'],
      id: json['id'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      name: json['name'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      visibility: json['visibility'],
      weather: json['weather'] != null
          ? (json['weather'] as List).map((i) => Weather.fromJson(i)).toList()
          : null,
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      dateTime: dates[1]
    );
  }

//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['dt'] = this.dt;
//    data['id'] = this.id;
//    data['name'] = this.name;
//    data['timezone'] = this.timezone;
//    data['visibility'] = this.visibility;
//    if (this.main != null) {
//      data['main'] = this.main.toJson();
//    }
//    if (this.sys != null) {
//      data['sys'] = this.sys.toJson();
//    }
//    if (this.weather != null) {
//      data['weather'] = this.weather.map((v) => v.toJson()).toList();
//    }
//    if (this.wind != null) {
//      data['wind'] = this.wind.toJson();
//    }
//    return data;
//  }
}

class FiveDayForecast {
  City city;
  List<ForecastDay> forecast;
  ForecastDay todayForecast;

  FiveDayForecast({this.city, this.forecast, this.todayForecast});

  factory FiveDayForecast.fromJson(Map<String, dynamic> json) {
    var forecastCalculator = ForecastCalculator();
    var fiveDayThreeHourData = json['list'] != null
        ? (json['list'] as List)
            .map((i) => WeatherForecast.fromJson(i))
            .toList()
        : null;
    ForecastResult dailyForecast = forecastCalculator.getDailyForecast(
        fiveDayThreeHourData, json['city']['timezone']);
    return FiveDayForecast(
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      forecast: json['list'] != null ? dailyForecast.fiveDayForecast : [],
      todayForecast: json['list'] != null ? dailyForecast.todayForecast : [],
    );
  }
}

class Main {
  num feelsLike;
  int humidity;
  int pressure;
  num temp;
  num tempMax;
  num tempMin;

  Main(
      {this.feelsLike,
      this.humidity,
      this.pressure,
      this.temp,
      this.tempMax,
      this.tempMin});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      feelsLike: json['feels_like'],
      humidity: json['humidity'],
      pressure: json['pressure'],
      temp: json['temp'],
      tempMax: json['temp_max'],
      tempMin: json['temp_min'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feels_like'] = this.feelsLike;
    data['humidity'] = this.humidity;
    data['pressure'] = this.pressure;
    data['temp'] = this.temp;
    data['temp_max'] = this.tempMax;
    data['temp_min'] = this.tempMin;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['main'] = this.main;
    return data;
  }
}

class Sys {
  String country;
  int id;
  int sunrise;
  int sunset;
  int type;

  Sys({this.country, this.id, this.sunrise, this.sunset, this.type});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json['country'],
      id: json['id'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['id'] = this.id;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['type'] = this.type;
    return data;
  }
}

class Wind {
  int deg;
  num speed;

  Wind({this.deg, this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      deg: json['deg'],
      speed: json['speed'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deg'] = this.deg;
    data['speed'] = this.speed;
    return data;
  }
}

class City {
  String country;
  int id;
  String name;
  int sunrise;
  int sunset;
  int timezone;

  City(
      {this.country,
      this.id,
      this.name,
      this.sunrise,
      this.sunset,
      this.timezone});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      country: json['country'],
      id: json['id'],
      name: json['name'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      timezone: json['timezone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['id'] = this.id;
    data['name'] = this.name;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['timezone'] = this.timezone;
    return data;
  }
}

class WeatherForecast {
  int dt;
  Main main;
  List<Weather> weather;
  Wind wind;
  String dtTxt;

  WeatherForecast({this.dt, this.main, this.weather, this.wind, this.dtTxt});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      dt: json['dt'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      weather: json['weather'] != null
          ? (json['weather'] as List).map((i) => Weather.fromJson(i)).toList()
          : null,
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      dtTxt: json['dt_txt'],
    );
  }
}


class WeatherIcons{
  static Map<String, dynamic>_icons = {
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

  static IconData icon(icon){
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

//  factory ForecastDay.fromJson(Map<String, dynamic> json) {
//    return ForecastDay(
//        date: json['date'],
//        weekday: json['date']['weekday'],
//        tempMax: json['date']['tempMax'],
//        tempMin: json['date']['tempMin'],
//        description: json['date']['description'],
//        icon: json['date']['icon']);
//  }
}

class ForecastResult {
  final ForecastDay todayForecast;
  final List<ForecastDay> fiveDayForecast;

  ForecastResult({this.todayForecast, this.fiveDayForecast});
}

class DateHelper {
  static List<dynamic> getDates(int timezone, int timestamp, {String dateFormat = 'yyyy-MM-dd'}) {
    DateTime localDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
        .add(Duration(seconds: timezone));
    String formattedDate = DateFormat(dateFormat).format(localDate);
    String weekday = DateFormat('E').format(localDate);
    return [weekday, formattedDate];
  }

  static String getToday(int timezone) {
    DateTime localToday = DateTime.now().add(Duration(seconds: timezone));
    return DateFormat('yyyy-MM-dd').format(localToday);
  }
}

class ForecastCalculator {
  ForecastResult getDailyForecast(List fiveDayThreeHourData, int timezone) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    for (final threeHourSlot in fiveDayThreeHourData) {
      List dates = DateHelper.getDates(timezone, threeHourSlot.dt);
      String weekday = dates[0], date = dates[1];
//
      if (data.containsKey(date)) {
        data[date]['tempMax'] = data[date]['tempMax'] > threeHourSlot.main.temp
            ? data[date]['tempMax']
            : threeHourSlot.main.temp;
        data[date]['tempMin'] = data[date]['tempMin'] < threeHourSlot.main.temp
            ? data[date]['tempMin']
            : threeHourSlot.main.temp;
      } else {
        data[date] = {
          'weekday': weekday,
          'tempMax':
              threeHourSlot.main.temp != null ? threeHourSlot.main.temp : null,
          'tempMin':
              threeHourSlot.main.temp != null ? threeHourSlot.main.temp : null,
          'description': "",
        };
      }
      if (threeHourSlot.dtTxt.endsWith('12:00:00')) {
        data[date]['description'] = threeHourSlot.weather[0].description;
        data[date]['icon'] = threeHourSlot.weather[0].icon;
      }
    }
    var uniqueDates = data.keys.toList();
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
            description: data[date]['description'],
            icon: data[date]['icon']);
      } else {
        forecastData.add(ForecastDay(
            date: date,
            weekday: data[date]['weekday'],
            tempMax: data[date]['tempMax'],
            tempMin: data[date]['tempMin'],
            description: data[date]['description'],
            icon: data[date]['icon']));
      }
    }

    return ForecastResult(
        todayForecast: todayForecast, fiveDayForecast: forecastData);
  }
}
