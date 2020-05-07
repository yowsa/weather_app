import 'package:flutter_test/flutter_test.dart';

import 'package:weatherapp/viewmodel/weather_parser.dart';

void main() {
  test(
      'Get formatted date in local time according to supplied format if applicable',
      () {
    Map<String, dynamic> testJsonForecast = {
      "cod": "200",
      "message": 0,
      "cnt": 40,
      "list": [
        {
          "dt": 1589144400,
          "main": {
            "temp": 279.83,
            "feels_like": 272.71,
            "temp_min": 279.83,
            "temp_max": 279.83,
            "pressure": 1019,
            "sea_level": 1019,
            "grnd_level": 1016,
            "humidity": 60,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 100},
          "wind": {"speed": 7.23, "deg": 43},
          "sys": {"pod": "n"},
          "dt_txt": "2020-05-10 21:00:00"
        },
        {
          "dt": 1589155200,
          "main": {
            "temp": 278.83,
            "feels_like": 271.65,
            "temp_min": 278.83,
            "temp_max": 278.83,
            "pressure": 1019,
            "sea_level": 1019,
            "grnd_level": 1016,
            "humidity": 63,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04n"
            }
          ],
          "clouds": {"all": 98},
          "wind": {"speed": 7.25, "deg": 44},
          "sys": {"pod": "n"},
          "dt_txt": "2020-05-11 00:00:00"
        },
        {
          "dt": 1589187600,
          "main": {
            "temp": 282.34,
            "feels_like": 275.09,
            "temp_min": 282.34,
            "temp_max": 282.34,
            "pressure": 1020,
            "sea_level": 1020,
            "grnd_level": 1018,
            "humidity": 49,
            "temp_kf": 0
          },
          "weather": [
            {
              "id": 801,
              "main": "Clouds",
              "description": "few clouds",
              "icon": "02d"
            }
          ],
          "clouds": {"all": 22},
          "wind": {"speed": 7.32, "deg": 43},
          "sys": {"pod": "d"},
          "dt_txt": "2020-05-11 09:00:00"
        },
      ],
      "city": {
        "id": 2643743,
        "name": "London",
        "coord": {"lat": 51.5085, "lon": -0.1257},
        "country": "GB",
        "population": 1000000,
        "timezone": 3600,
        "sunrise": 1588825251,
        "sunset": 1588879992
      }
    };

    FiveDayForecast fiveDayForecast =
        FiveDayForecast.fromJson(testJsonForecast);

    expect(fiveDayForecast.forecast.length, 2);
    expect(fiveDayForecast.forecast[0].tempMax, 279.83);
    expect(fiveDayForecast.forecast[1].tempMax, 282.34);
    expect(fiveDayForecast.forecast[1].weekday, 'Mon');
  });



  test(
      'Get formatted date in local time according to supplied format if applicable',
          () {
        Map<String, dynamic> testJsonCurrent = {
          "coord": {
            "lon": -0.13,
            "lat": 51.51
          },
          "weather": [
            {
              "id": 800,
              "main": "Clear",
              "description": "clear sky",
              "icon": "01d"
            }
          ],
          "base": "stations",
          "main": {
            "temp": 295.27,
            "feels_like": 293.04,
            "temp_min": 293.71,
            "temp_max": 296.48,
            "pressure": 1021,
            "humidity": 37
          },
          "visibility": 10000,
          "wind": {
            "speed": 2.1
          },
          "clouds": {
            "all": 0
          },
          "dt": 1588861184,
          "sys": {
            "type": 1,
            "id": 1414,
            "country": "GB",
            "sunrise": 1588825252,
            "sunset": 1588879993
          },
          "timezone": 3600,
          "id": 2643743,
          "name": "London",
          "cod": 200
        };

        CurrentWeather currentWeather =
        CurrentWeather.fromJson(testJsonCurrent);

        expect(currentWeather.temperature, 295.27);
        expect(currentWeather.location, "London");
        expect(currentWeather.dateTime, '15:19 Thursday, 7 May');
        expect(currentWeather.humidity, 37);
      });
}
