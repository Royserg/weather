import 'package:equatable/equatable.dart';

abstract class CityListEvent extends Equatable {
  const CityListEvent();

  @override
  List<Object?> get props => [];
}

class OnCityListGet extends CityListEvent {
  const OnCityListGet();

  @override
  List<Object?> get props => [];
}
