import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/city/data/data_sources/remote_data_source.dart';
import 'package:weather/features/city/domain/entities/city.dart';
import 'package:weather/features/city/domain/repositories/city_repository.dart';

class CityRepositoryImpl extends CityRepository {
  final CityRemoteDataSource cityRemoteDataSource;
  CityRepositoryImpl({required this.cityRemoteDataSource});

  @override
  Future<Either<Failure, List<CityEntity>>> searchCity(String query) async {
    try {
      final result = await cityRemoteDataSource.searchCity(query);
      return Right(result.map((city) => city.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred.'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network.'));
    }
  }
}