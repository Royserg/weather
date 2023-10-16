import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/city/domain/entities/city.dart';
import 'package:weather/features/city/domain/repositories/city_repository.dart';

class SearchCityUseCase {
  final CityRepository cityRepository;

  const SearchCityUseCase(this.cityRepository);

  Future<Either<Failure, List<CityEntity>>> execute(String query) {
    return cityRepository.searchCity(query);
  }
}
