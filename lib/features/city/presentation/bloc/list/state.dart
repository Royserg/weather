import 'package:equatable/equatable.dart';
import 'package:weather/features/city/domain/entities/city.dart';

abstract class CityListState extends Equatable {
  const CityListState();

  @override
  List<Object?> get props => [];
}

class CityListEmpty extends CityListState {}

class CityListLoading extends CityListState {}

class CityListLoaded extends CityListState {
  final List<CityEntity> result;

  const CityListLoaded(this.result);

  @override
  List<Object?> get props => [result];
}

class CityListLoadFailure extends CityListState {
  final String message;

  const CityListLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}
