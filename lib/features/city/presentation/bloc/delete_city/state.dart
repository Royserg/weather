import 'package:equatable/equatable.dart';

abstract class CityDeleteState extends Equatable {
  const CityDeleteState();

  @override
  List<Object?> get props => [];
}

class CityDeleteEmpty extends CityDeleteState {}

class CityDeleteLoading extends CityDeleteState {}

class CityDeleteSuccess extends CityDeleteState {}

class CityDeleteFailure extends CityDeleteState {}
