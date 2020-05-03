import 'package:weatherapp/viewmodel/weather_data.dart';
import 'package:weatherapp/viewmodel/weather.dart';

class UpdateWeather {

  Future<CurrentWeather> _futureCurrentWeather;
  Future<FiveDayForecast> _futureFiveDayForecast;

  UpdateWeather() {
    WeatherData weatherData = new WeatherData();
    this._futureCurrentWeather = weatherData.currentWeatherData();
    this._futureFiveDayForecast = weatherData.fiveDayForecastData();
  }

    onButtonClick(){


    }

  Future<CurrentWeather> getWeatherToday(){
    return this._futureCurrentWeather;
  }

  Future<FiveDayForecast> getWeatherForecast(){
    return this._futureFiveDayForecast;
  }


}