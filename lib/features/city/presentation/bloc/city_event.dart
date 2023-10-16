import 'package:equatable/equatable.dart';
import 'package:weather/features/city/domain/entities/city.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object?> get props => [];
}

class OnCitySearch extends CityEvent {
  final String query;

  const OnCitySearch(this.query);

  @override
  List<Object?> get props => [query];
}

class OnCitySave extends CityEvent {
  final CityEntity city;

  const OnCitySave(this.city);

  @override
  List<Object?> get props => [city];
}
