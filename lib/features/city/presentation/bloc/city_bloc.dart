import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/features/city/domain/usecases/save_city.dart';
import 'package:weather/features/city/domain/usecases/search_city.dart';
import 'package:weather/features/city/presentation/bloc/city_event.dart';
import 'package:weather/features/city/presentation/bloc/city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final SearchCityUseCase _searchCityUseCase;
  final SaveCityUseCase _saveCityUseCase;

  CityBloc(this._searchCityUseCase, this._saveCityUseCase)
      : super(CitiesEmpty()) {
    // -- city search
    on<OnCitySearch>(
      (event, emit) async {
        if (event.query.isEmpty) {
          emit(CitiesEmpty());
          return;
        }

        emit(CitiesLoading());

        final result = await _searchCityUseCase.execute(event.query);
        result.fold(
          (failure) {
            emit(CitiesLoadFailure(failure.message));
          },
          (data) {
            emit(CitiesLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
    // -- city save
    on<OnCitySave>((event, emit) {
      emit(CitySaveLoading());

      final result = _saveCityUseCase.execute(event.city);
      result.fold((failure) {
        emit(CitySaveFailure());
      }, (data) {
        emit(CitySaveSuccess());
      });
    });
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
