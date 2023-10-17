import 'package:equatable/equatable.dart';

abstract class CityDeleteEvent extends Equatable {
  const CityDeleteEvent();

  @override
  List<Object?> get props => [];
}

class OnCityDelete extends CityDeleteEvent {
  final int id;

  const OnCityDelete(this.id);

  @override
  List<Object?> get props => [id];
}
