import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  const WeatherEntity({
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
  });

  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentUnitsEntity currentUnits;
  final CurrentEntity current;
  final HourlyUnitsEntity hourlyUnits;
  final HourlyEntity hourly;

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        generationtimeMs,
        utcOffsetSeconds,
        timezone,
        timezoneAbbreviation,
        elevation,
        currentUnits,
        current,
        hourlyUnits,
        hourly,
      ];
}

class CurrentUnitsEntity {
  final String time;
  final String interval;
  final String temperature2m;
  final String apparentTemperature;
  final String precipitation;
  final String weathercode;

  CurrentUnitsEntity({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.apparentTemperature,
    required this.precipitation,
    required this.weathercode,
  });
}

class CurrentEntity {
  String time;
  int interval;
  double temperature2m;
  double apparentTemperature;
  double precipitation;
  int weathercode;

  CurrentEntity({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.apparentTemperature,
    required this.precipitation,
    required this.weathercode,
  });
}

class HourlyUnitsEntity {
  final String time;
  final String temperature2m;
  final String weathercode;
  final String isDay;

  HourlyUnitsEntity({
    required this.time,
    required this.temperature2m,
    required this.weathercode,
    required this.isDay,
  });
}

class HourlyEntity {
  final List<String> time;
  final List<double> temperature2m;
  final List<int> weathercode;
  final List<int> isDay;

  HourlyEntity({
    required this.time,
    required this.temperature2m,
    required this.weathercode,
    required this.isDay,
  });
}
