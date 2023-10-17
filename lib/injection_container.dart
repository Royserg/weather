import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather/features/city/data/data_sources/local/app_database.dart';
import 'package:weather/features/city/data/data_sources/remote/remote_data_source.dart';
import 'package:weather/features/city/data/repositories/city_repository_impl.dart';
import 'package:weather/features/city/domain/repositories/city_repository.dart';
import 'package:weather/features/city/domain/usecases/get_saved_cities.dart';
import 'package:weather/features/city/domain/usecases/remove_city.dart';
import 'package:weather/features/city/domain/usecases/save_city.dart';
import 'package:weather/features/city/domain/usecases/search_city.dart';
import 'package:weather/features/city/presentation/bloc/delete_city/bloc.dart';
import 'package:weather/features/city/presentation/bloc/list/bloc.dart';
import 'package:weather/features/city/presentation/bloc/save_city/bloc.dart';
import 'package:weather/features/city/presentation/bloc/search_city/bloc.dart';
import 'package:weather/features/weather/data/data_sources/remote_data_source.dart';
import 'package:weather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather/features/weather/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  // bloc
  locator.registerFactory<WeatherBloc>(() => WeatherBloc(locator()));

  locator.registerFactory<CitySearchBloc>(() => CitySearchBloc(locator()));
  locator.registerFactory<CitySaveBloc>(() => CitySaveBloc(locator()));
  locator.registerFactory<CityDeleteBloc>(() => CityDeleteBloc(locator()));
  locator.registerFactory<CityListBloc>(() => CityListBloc(locator()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  locator.registerLazySingleton(() => SearchCityUseCase(locator()));
  locator.registerLazySingleton(() => SaveCityUseCase(locator()));
  locator.registerLazySingleton(() => RemoveCityUseCase(locator()));
  locator.registerLazySingleton(() => GetSavedCitiesUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  );
  locator.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(
      cityRemoteDataSource: locator(),
      appDatabase: locator(),
    ),
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
