import 'package:equatable/equatable.dart';

abstract class CitySaveState extends Equatable {
  const CitySaveState();

  @override
  List<Object?> get props => [];
}

class CitySaveEmpty extends CitySaveState {}

class CitySaveLoading extends CitySaveState {}

class CitySaveSuccess extends CitySaveState {}

class CitySaveFailure extends CitySaveState {}
