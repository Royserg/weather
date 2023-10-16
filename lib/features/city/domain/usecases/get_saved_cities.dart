import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/city/domain/entities/city.dart';
import 'package:weather/features/city/domain/repositories/city_repository.dart';

class GetSavedCitiesUseCase {
  final CityRepository cityRepository;

  const GetSavedCitiesUseCase(this.cityRepository);

  Future<Either<Failure, List<CityEntity>>> execute() async {
    return cityRepository.getSavedCities();
  }
}
