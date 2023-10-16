import 'package:weather/features/weather/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.hourlyUnits,
    required this.hourly,
  }) : super(
          latitude: latitude,
          longitude: longitude,
          generationtimeMs: generationtimeMs,
          utcOffsetSeconds: utcOffsetSeconds,
          timezone: timezone,
          timezoneAbbreviation: timezoneAbbreviation,
          elevation: elevation,
          currentUnits: currentUnits,
          current: current,
          hourlyUnits: hourlyUnits,
          hourly: hourly,
        );

  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentUnitsModel currentUnits;
  final CurrentModel current;
  final HourlyUnitsModel hourlyUnits;
  final HourlyModel hourly;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        latitude: json['latitude'],
        longitude: json['longitude'],
        generationtimeMs: json['generationtime_ms'],
        utcOffsetSeconds: json['utc_offset_seconds'],
        timezone: json['timezone'],
        timezoneAbbreviation: json['timezone_abbreviation'],
        elevation: json['elevation'],
        currentUnits: CurrentUnitsModel.fromJson(json['current_units']),
        current: CurrentModel.fromJson(json['current']),
        hourlyUnits: HourlyUnitsModel.fromJson(json['hourly_units']),
        hourly: HourlyModel.fromJson(json['hourly']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['generationtime_ms'] = this.generationtimeMs;
    data['utc_offset_seconds'] = this.utcOffsetSeconds;
    data['timezone'] = this.timezone;
    data['timezone_abbreviation'] = this.timezoneAbbreviation;
    data['elevation'] = this.elevation;
    if (this.currentUnits != null) {
      data['current_units'] = this.currentUnits!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
    if (this.hourlyUnits != null) {
      data['hourly_units'] = this.hourlyUnits!.toJson();
    }
    if (this.hourly != null) {
      data['hourly'] = this.hourly!.toJson();
    }
    return data;
  }

  WeatherEntity toEntity() => WeatherEntity(
      latitude: latitude,
      longitude: longitude,
      generationtimeMs: generationtimeMs,
      utcOffsetSeconds: utcOffsetSeconds,
      timezone: timezone,
      timezoneAbbreviation: timezoneAbbreviation,
      elevation: elevation,
      currentUnits: currentUnits,
      current: current,
      hourlyUnits: hourlyUnits,
      hourly: hourly);
}

class CurrentUnitsModel extends CurrentUnitsEntity {
  final String time;
  final String interval;
  final String temperature2m;
  final String apparentTemperature;
  final String precipitation;
  final String weathercode;

  CurrentUnitsModel({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.apparentTemperature,
    required this.precipitation,
    required this.weathercode,
  }) : super(
          time: time,
          interval: interval,
          temperature2m: temperature2m,
          apparentTemperature: apparentTemperature,
          precipitation: precipitation,
          weathercode: weathercode,
        );

  factory CurrentUnitsModel.fromJson(Map<String, dynamic> json) =>
      CurrentUnitsModel(
        time: json['time'],
        interval: json['interval'],
        temperature2m: json['temperature_2m'],
        apparentTemperature: json['apparent_temperature'],
        precipitation: json['precipitation'],
        weathercode: json['weathercode'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['interval'] = this.interval;
    data['temperature_2m'] = this.temperature2m;
    data['apparent_temperature'] = this.apparentTemperature;
    data['precipitation'] = this.precipitation;
    data['weathercode'] = this.weathercode;
    return data;
  }
}

class CurrentModel extends CurrentEntity {
  final String time;
  final int interval;
  final double temperature2m;
  final double apparentTemperature;
  final double precipitation;
  final int weathercode;

  CurrentModel({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.apparentTemperature,
    required this.precipitation,
    required this.weathercode,
  }) : super(
          time: time,
          interval: interval,
          temperature2m: temperature2m,
          apparentTemperature: apparentTemperature,
          precipitation: precipitation,
          weathercode: weathercode,
        );

  factory CurrentModel.fromJson(Map<String, dynamic> json) => CurrentModel(
        time: json['time'],
        interval: json['interval'],
        temperature2m: json['temperature_2m'],
        apparentTemperature: json['apparent_temperature'],
        precipitation: json['precipitation'],
        weathercode: json['weathercode'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['interval'] = this.interval;
    data['temperature_2m'] = this.temperature2m;
    data['apparent_temperature'] = this.apparentTemperature;
    data['precipitation'] = this.precipitation;
    data['weathercode'] = this.weathercode;
    return data;
  }
}

class HourlyUnitsModel extends HourlyUnitsEntity {
  final String time;
  final String temperature2m;
  final String weathercode;
  final String isDay;

  HourlyUnitsModel({
    required this.time,
    required this.temperature2m,
    required this.weathercode,
    required this.isDay,
  }) : super(
          time: time,
          temperature2m: temperature2m,
          weathercode: weathercode,
          isDay: isDay,
        );

  factory HourlyUnitsModel.fromJson(Map<String, dynamic> json) =>
      HourlyUnitsModel(
        time: json['time'],
        temperature2m: json['temperature_2m'],
        weathercode: json['weathercode'],
        isDay: json['is_day'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['temperature_2m'] = this.temperature2m;
    data['weathercode'] = this.weathercode;
    data['is_day'] = this.isDay;
    return data;
  }
}

class HourlyModel extends HourlyEntity {
  final List<String> time;
  final List<double> temperature2m;
  final List<int> weathercode;
  final List<int> isDay;

  HourlyModel({
    required this.time,
    required this.temperature2m,
    required this.weathercode,
    required this.isDay,
  }) : super(
          time: time,
          temperature2m: temperature2m,
          weathercode: weathercode,
          isDay: isDay,
        );

  factory HourlyModel.fromJson(Map<String, dynamic> json) => HourlyModel(
        time: json['time'].cast<String>(),
        temperature2m: json['temperature_2m'].cast<double>(),
        weathercode: json['weathercode'].cast<int>(),
        isDay: json['is_day'].cast<int>(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['temperature_2m'] = this.temperature2m;
    data['weathercode'] = this.weathercode;
    data['is_day'] = this.isDay;
    return data;
  }
}
