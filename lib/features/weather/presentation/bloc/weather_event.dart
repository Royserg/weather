import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class OnWeatherGet extends WeatherEvent {
  final String cityName;

  const OnWeatherGet(this.cityName);

  @override
  List<Object?> get props => [cityName];
}
