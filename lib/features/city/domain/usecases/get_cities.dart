import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/city/domain/entities/city.dart';
import 'package:weather/features/city/domain/repositories/city_repository.dart';

class GetCitiesUseCase {
  final CityRepository cityRepository;

  const GetCitiesUseCase(this.cityRepository);

  Either<Failure, List<CityEntity>> execute() {
    return cityRepository.getCities();
  }
}
