import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather/features/weather/presentation/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnWeatherGet>(
      (event, emit) async {
        emit(WeatherLoading());

        final result = await _getCurrentWeatherUseCase.execute(event.cityName);
        result.fold(
          (failure) {
            emit(WeatherLoadFailure(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
    );
  }
}
