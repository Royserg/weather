import 'package:equatable/equatable.dart';

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
