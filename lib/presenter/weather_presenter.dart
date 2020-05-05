import 'package:weatherapp/viewmodel/weather_data.dart';
import 'package:weatherapp/viewmodel/weather.dart';

class UpdateWeather {
  Future<AllWeatherData> futureAllWeatherData;
  WeatherData weatherData;

  UpdateWeather() {
    this.weatherData = new WeatherData();
    this.futureAllWeatherData = weatherData.getWeatherData();
  }

  Future<AllWeatherData> getWeatherData(){
    return this.weatherData.getWeatherData();
  }
}