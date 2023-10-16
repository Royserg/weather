import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/city/domain/usecases/get_saved_cities.dart';
import 'package:weather/features/city/presentation/bloc/list/event.dart';
import 'package:weather/features/city/presentation/bloc/list/state.dart';

class CityListBloc extends Bloc<CityListEvent, CityListState> {
  final GetSavedCitiesUseCase _getSavedCitiesUseCase;

  CityListBloc(this._getSavedCitiesUseCase) : super(CityListEmpty()) {
    on<OnCityListGet>((event, emit) async {
      emit(CityListLoading());

      final result = await _getSavedCitiesUseCase.execute();
      result.fold(
        (failure) {
          emit(CityListLoadFailure(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            emit(CityListEmpty());
            return;
          }
          emit(CityListLoaded(data));
        },
      );
    });
  }
}
