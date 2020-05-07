import 'package:weatherapp/viewmodel/weather_data.dart';

class UpdateWeather {
  Future<AllWeatherData> futureAllWeatherData;
  WeatherData weatherData;

  UpdateWeather() {
    this.weatherData = new WeatherData();
  }

  Future<AllWeatherData> getWeatherData(){
    return this.weatherData.getWeatherData();
  }
}