import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/city/domain/repositories/city_repository.dart';

class RemoveCityUseCase {
  final CityRepository cityRepository;

  const RemoveCityUseCase(this.cityRepository);

  Future<Either<Failure, void>> execute(int id) {
    debugPrint("DELETEING in usecase id: $id");
    return cityRepository.removeCityById(id);
  }
}
