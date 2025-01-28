import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  const WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  final Coord? coord;
  final List<Weather> weather;
  final String base;
  final Main? main;
  final int visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int dt;
  final Sys? sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
      weather: json["weather"] == null
          ? []
          : List<Weather>.from(
              json["weather"]!.map((x) => Weather.fromJson(x))),
      base: json["base"] ?? "",
      main: json["main"] == null ? null : Main.fromJson(json["main"]),
      visibility: json["visibility"] ?? 0,
      wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
      clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
      dt: json["dt"] ?? 0,
      sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
      timezone: json["timezone"] ?? 0,
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      cod: json["cod"] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        coord,
        weather,
        base,
        main,
        visibility,
        wind,
        clouds,
        dt,
        sys,
        timezone,
        id,
        name,
        cod,
      ];
}

class Clouds extends Equatable {
  const Clouds({
    required this.all,
  });

  final int all;

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json["all"] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        all,
      ];
}

class Coord extends Equatable {
  const Coord({
    required this.lon,
    required this.lat,
  });

  final double lon;
  final double lat;

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json["lon"] ?? 0.0,
      lat: json["lat"] ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [
        lon,
        lat,
      ];
}

class Main extends Equatable {
  const Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json["temp"] ?? 0.0,
      feelsLike: json["feels_like"] ?? 0.0,
      tempMin: json["temp_min"] ?? 0.0,
      tempMax: json["temp_max"] ?? 0.0,
      pressure: json["pressure"] ?? 0,
      humidity: json["humidity"] ?? 0,
      seaLevel: json["sea_level"] ?? 0,
      grndLevel: json["grnd_level"] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        temp,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        humidity,
        seaLevel,
        grndLevel,
      ];
}

class Sys extends Equatable {
  const Sys({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  final String country;
  final int sunrise;
  final int sunset;

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      country: json["country"] ?? "",
      sunrise: json["sunrise"] ?? 0,
      sunset: json["sunset"] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        country,
        sunrise,
        sunset,
      ];
}

class Weather extends Equatable {
  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json["id"] ?? 0,
      main: json["main"] ?? "",
      description: json["description"] ?? "",
      icon: json["icon"] ?? "",
    );
  }

  @override
  List<Object?> get props => [
        id,
        main,
        description,
        icon,
      ];
}

class Wind extends Equatable {
  const Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  final double speed;
  final int deg;
  final double gust;

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json["speed"] ?? 0.0,
      deg: json["deg"] ?? 0,
      gust: json["gust"] ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [
        speed,
        deg,
        gust,
      ];
}
