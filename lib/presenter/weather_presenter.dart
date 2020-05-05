import 'package:weatherapp/viewmodel/weather_data.dart';
import 'package:weatherapp/viewmodel/weather.dart';

class UpdateWeather {

  Future<CurrentWeather> _futureCurrentWeather;
  Future<FiveDayForecast> _futureFiveDayForecast;
  Future<AllWeatherData> futureAllWeatherData;
  WeatherData weatherData;

  UpdateWeather() {
    this.weatherData = new WeatherData();
    this.futureAllWeatherData = weatherData.getWeatherData();

//    this._futureCurrentWeather = weatherData.currentWeatherData();
//    this._futureFiveDayForecast = weatherData.fiveDayForecastData();
  }

  Future<AllWeatherData> getWeatherData(){
    return this.weatherData.getWeatherData();
  }

//  Future<FiveDayForecast> getWeatherForecast(){
//    return this._futureFiveDayForecast;
//  }


}