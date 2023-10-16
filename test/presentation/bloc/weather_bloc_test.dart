import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/error/failure.dart';
import 'package:weather/features/weather/domain/entities/weather.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather/features/weather/presentation/bloc/weather_state.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

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

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when getting data is successful',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
        (_) async => const Right(testWeatherEntity),
      );
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(testWeatherEntity),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoadFailure] when getting data is unsuccessful',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailure('Server Failure'),
    ],
  );
}
