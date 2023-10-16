import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/weather/data/data_sources/remote_data_source.dart';
import 'package:weather/features/weather/domain/entities/weather.dart';
import 'package:weather/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      double latitude, double longitude) async {
    try {
      final result =
          await weatherRemoteDataSource.getCurrentWeather(latitude, longitude);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred.'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network.'));
    }
  }
}
