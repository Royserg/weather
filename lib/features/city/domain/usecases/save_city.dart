import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/city/domain/entities/city.dart';
import 'package:weather/features/city/domain/repositories/city_repository.dart';

class SaveCityUseCase {
  final CityRepository cityRepository;

  const SaveCityUseCase(this.cityRepository);

  Future<Either<Failure, void>> execute(CityEntity city) {
    return cityRepository.saveCity(city);
  }
}
