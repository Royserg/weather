import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/city/domain/entities/city.dart';

abstract class CityRepository {
  // API methods
  Future<Either<Failure, List<CityEntity>>> searchCity(String query);

  // Db methods
  Future<Either<Failure, List<CityEntity>>> getSavedCities();
  Future<Either<Failure, void>> saveCity(CityEntity city);
  Future<void> removeCityById(int id);
}
