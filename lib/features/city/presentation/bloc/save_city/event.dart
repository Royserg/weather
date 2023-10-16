import 'package:equatable/equatable.dart';
import 'package:weather/features/city/domain/entities/city.dart';

abstract class CitySaveEvent extends Equatable {
  const CitySaveEvent();

  @override
  List<Object?> get props => [];
}

class OnCitySave extends CitySaveEvent {
  final CityEntity city;

  const OnCitySave(this.city);

  @override
  List<Object?> get props => [city];
}
