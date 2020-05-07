import 'package:flutter/material.dart';

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
