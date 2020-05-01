class WeatherToday {
    String base;
    Clouds clouds;
    int cod;
    Coord coord;
    int dt;
    int id;
    Main main;
    String name;
    Sys sys;
    int timezone;
    int visibility;
    List<Weather> weather;
    Wind wind;

    WeatherToday({this.base, this.clouds, this.cod, this.coord, this.dt, this.id, this.main, this.name, this.sys, this.timezone, this.visibility, this.weather, this.wind});

    factory WeatherToday.fromJson(Map<String, dynamic> json) {
        return WeatherToday(
            base: json['base'],
            clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
            cod: json['cod'],
            coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
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
        data['base'] = this.base;
        data['cod'] = this.cod;
        data['dt'] = this.dt;
        data['id'] = this.id;
        data['name'] = this.name;
        data['timezone'] = this.timezone;
        data['visibility'] = this.visibility;
        if (this.clouds != null) {
            data['clouds'] = this.clouds.toJson();
        }
        if (this.coord != null) {
            data['coord'] = this.coord.toJson();
        }
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

class Wind {
    int deg;
    double speed;

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

class Main {
    double feelsLike;
    int humidity;
    int pressure;
    double temp;
    double tempMax;
    double tempMin;

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

class Coord {
    double lat;
    double lon;

    Coord({this.lat, this.lon});

    factory Coord.fromJson(Map<String, dynamic> json) {
        return Coord(
            lat: json['lat'],
            lon: json['lon'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['lat'] = this.lat;
        data['lon'] = this.lon;
        return data;
    }
}

class Clouds {
    int all;

    Clouds({this.all});

    factory Clouds.fromJson(Map<String, dynamic> json) {
        return Clouds(
            all: json['all'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['all'] = this.all;
        return data;
    }
}