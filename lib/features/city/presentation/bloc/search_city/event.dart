import 'package:equatable/equatable.dart';

abstract class CitySearchEvent extends Equatable {
  const CitySearchEvent();

  @override
  List<Object?> get props => [];
}

class OnCitySearch extends CitySearchEvent {
  final String query;

  const OnCitySearch(this.query);

  @override
  List<Object?> get props => [query];
}
