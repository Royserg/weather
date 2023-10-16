import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/city/data/data_sources/local/app_database.dart';
import 'package:weather/features/city/data/data_sources/remote/remote_data_source.dart';
import 'package:weather/features/city/data/models/city_model.dart';
import 'package:weather/features/city/domain/entities/city.dart';
import 'package:weather/features/city/domain/repositories/city_repository.dart';

class CityRepositoryImpl extends CityRepository {
  final CityRemoteDataSource cityRemoteDataSource;
  final AppDatabase appDatabase;

  CityRepositoryImpl(
      {required this.cityRemoteDataSource, required this.appDatabase});

  List<CityEntity> cities = [];

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

  @override
  Future<Either<Failure, List<CityModel>>> getSavedCities() async {
    try {
      final result = await appDatabase.cityDao.getCities();
      return Right(result);
    } catch (err) {
      return const Left(ServerFailure("Failed to get city list"));
    }
  }

  @override
  Future<void> removeCityById(int id) {
    return appDatabase.cityDao.deleteCityById(id);
  }

  @override
  Future<Either<Failure, void>> saveCity(CityEntity city) async {
    try {
      await appDatabase.cityDao.insertCity(CityModel.fromEntity(city));
      // ignore: void_checks
      return const Right(Unit);
    } catch (err) {
      return const Left(ServerFailure("Failed to save city"));
    }
  }
}
