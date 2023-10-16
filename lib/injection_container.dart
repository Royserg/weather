import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather/features/city/data/data_sources/remote_data_source.dart';
import 'package:weather/features/city/data/repositories/city_repository_impl.dart';
import 'package:weather/features/city/domain/repositories/city_repository.dart';
import 'package:weather/features/city/domain/usecases/get_cities.dart';
import 'package:weather/features/city/domain/usecases/save_city.dart';
import 'package:weather/features/city/domain/usecases/search_city.dart';
import 'package:weather/features/city/presentation/bloc/list/bloc.dart';
import 'package:weather/features/city/presentation/bloc/save_city/bloc.dart';
import 'package:weather/features/city/presentation/bloc/search_city/bloc.dart';
import 'package:weather/features/weather/data/data_sources/remote_data_source.dart';
import 'package:weather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));
  locator.registerFactory(() => CitySearchBloc(locator()));
  locator.registerFactory(() => CitySaveBloc(locator()));
  locator.registerFactory(() => CityListBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));
  locator.registerLazySingleton(() => SearchCityUseCase(locator()));
  locator.registerLazySingleton(() => SaveCityUseCase(locator()));
  locator.registerLazySingleton(() => GetCitiesUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  );
  locator.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(cityRemoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<CityRemoteDataSource>(
    () => CityRemoteDataSourceImpl(client: locator()),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
