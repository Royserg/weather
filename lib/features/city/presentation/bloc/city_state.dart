import 'package:equatable/equatable.dart';
import 'package:weather/features/city/domain/entities/city.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object?> get props => [];
}

class CitiesEmpty extends CityState {}

class CitiesLoading extends CityState {}

class CitiesLoaded extends CityState {
  final List<CityEntity> result;

  const CitiesLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class CitiesLoadFailure extends CityState {
  final String message;

  const CitiesLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
