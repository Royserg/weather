import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/city/domain/entities/city.dart';
import 'package:weather/features/city/domain/repositories/city_repository.dart';

class SaveCityUseCase {
  final CityRepository cityRepository;

  const SaveCityUseCase(this.cityRepository);

  Either<Failure, Unit> execute(CityEntity city) {
    return cityRepository.saveCity(city);
  }
}
