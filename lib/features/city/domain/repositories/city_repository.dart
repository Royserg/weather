import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/city/domain/entities/city.dart';

abstract class CityRepository {
  Future<Either<Failure, List<CityEntity>>> searchCity(String query);
}
