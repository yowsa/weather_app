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

  CurrentWeather({this.dt, this.id, this.main, this.name, this.sys, this.timezone, this.visibility, this.weather, this.wind});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      dt: json['dt'],
      id: json['id'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      name: json['name'],
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      timezone: json['timezone'],
      visibility: json['visibility'],
      weather: json['weather'] != null ? (json['weather'] as List).map((i) => Weather.fromJson(i)).toList() : null,
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    data['id'] = this.id;
    data['name'] = this.name;
    data['timezone'] = this.timezone;
    data['visibility'] = this.visibility;
    if (this.main != null) {
      data['main'] = this.main.toJson();
    }
    if (this.sys != null) {
      data['sys'] = this.sys.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    return data;
  }
}


class FiveDayForecast {
  City city;
  List<WeatherForecast> list;

  FiveDayForecast({this.city, this.list});

  factory FiveDayForecast.fromJson(Map<String, dynamic> json) {
    return FiveDayForecast(
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      list: json['list'] != null ? (json['list'] as List).map((i) => WeatherForecast.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Main {
  num feelsLike;
  int humidity;
  int pressure;
  num temp;
  num tempMax;
  num tempMin;

  Main({this.feelsLike, this.humidity, this.pressure, this.temp, this.tempMax, this.tempMin});

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
  String icon;
  int id;
  String main;

  Weather({this.description, this.icon, this.id, this.main});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['description'],
      icon: json['icon'],
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

  City({this.country, this.id, this.name, this.sunrise, this.sunset, this.timezone});

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

  WeatherForecast({this.dt, this.main, this.weather, this.wind});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      dt: json['dt'],
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      weather: json['weather'] != null ? (json['weather'] as List).map((i) => Weather.fromJson(i)).toList() : null,
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    if (this.main != null) {
      data['main'] = this.main.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    if (this.wind != null) {
      data['wind'] = this.wind.toJson();
    }
    return data;
  }
}

