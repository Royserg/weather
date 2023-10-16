import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
      weatherRemoteDataSource: mockWeatherRemoteDataSource,
    );
  });

  const testWeatherModel = WeatherModel(
    cityName: 'Boston',
    main: 'Rain',
    description: 'huge raincloud',
    iconCode: '02d',
    temperature: 209.11,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'Boston',
    main: 'Rain',
    description: 'huge raincloud',
    iconCode: '02d',
    temperature: 209.11,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'Boston';

  group('get current weather', () {
    test(
        'should return current weather when a call to data source is successful',
        () async {
      // arrange
      when(
        mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
      ).thenAnswer((_) async => testWeatherModel);

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test(
        'should return server failure when when a call to a data source is unsuccessful',
        () async {
      // arrange
      when(
        mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
      ).thenThrow(ServerException());

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(
          result, equals(const Left(ServerFailure('An error has occurred.'))));
    });

    test('should return connection failure when the device has no internet',
        () async {
      // arrange
      when(
        mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
      ).thenThrow(const SocketException('Failed to connect to the network.'));

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(
        result,
        equals(
          const Left(
            ConnectionFailure('Failed to connect to the network.'),
          ),
        ),
      );
    });
  });
}
