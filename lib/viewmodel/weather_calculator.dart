import 'package:flutter/material.dart';

import 'date_helper.dart';


class ForecastCalculator {
  Map<String, dynamic> _getWeatherDescriptions(
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
          'description': threeHourSlot.description,
          'icon': threeHourSlot.icon
        };
        continue;
      }
      if (timeToNoon < data[date]['timeToNoon']) {
        data[date] = {
          'timeToNoon': timeToNoon,
          'description': threeHourSlot.description,
          'icon': threeHourSlot.icon
        };
      }
    }
    return data;
  }

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
          'tempMax': threeHourSlot.temperature,
          'tempMin': threeHourSlot.temperature
        };
      }
      data[date] = {
        'weekday': weekday,
        'tempMax': threeHourSlot.temperature > data[date]['tempMax']
            ? threeHourSlot.temperature
            : data[date]['tempMax'],
        'tempMin': threeHourSlot.temperature < data[date]['tempMin']
            ? threeHourSlot.temperature
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
        (_getWeatherDescriptions(fiveDayThreeHourData, timezone));
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

class ForecastResult {
  final ForecastDay todayForecast;
  final List<ForecastDay> fiveDayForecast;

  ForecastResult({this.todayForecast, this.fiveDayForecast});
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
