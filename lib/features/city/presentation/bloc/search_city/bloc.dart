import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/features/city/domain/usecases/search_city.dart';
import 'package:weather/features/city/presentation/bloc/search_city/event.dart';
import 'package:weather/features/city/presentation/bloc/search_city/state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final SearchCityUseCase _searchCityUseCase;

  CitySearchBloc(this._searchCityUseCase) : super(CitySuggestionsEmpty()) {
    on<OnCitySearch>(
      (event, emit) async {
        if (event.query.isEmpty) {
          emit(CitySuggestionsEmpty());
          return;
        }

        emit(CitySuggestionsLoading());

        final result = await _searchCityUseCase.execute(event.query);
        result.fold(
          (failure) {
            emit(CitySuggestionsLoadFailure(failure.message));
          },
          (data) {
            emit(CitySuggestionsLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
