import 'package:equatable/equatable.dart';
import 'package:weather/features/city/domain/entities/city.dart';

abstract class CitySearchState extends Equatable {
  const CitySearchState();

  @override
  List<Object?> get props => [];
}

class CitySuggestionsEmpty extends CitySearchState {}

class CitySuggestionsLoading extends CitySearchState {}

class CitySuggestionsLoaded extends CitySearchState {
  final List<CityEntity> result;

  const CitySuggestionsLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class CitySuggestionsLoadFailure extends CitySearchState {
  final String message;

  const CitySuggestionsLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
