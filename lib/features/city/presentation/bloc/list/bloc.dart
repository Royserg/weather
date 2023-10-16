import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/city/domain/usecases/get_cities.dart';
import 'package:weather/features/city/presentation/bloc/list/event.dart';
import 'package:weather/features/city/presentation/bloc/list/state.dart';

class CityListBloc extends Bloc<CityListEvent, CityListState> {
  final GetCitiesUseCase _getCitiesUseCase;

  CityListBloc(this._getCitiesUseCase) : super(CityListEmpty()) {
    on<OnCityListGet>((event, emit) {
      emit(CityListLoading());

      final result = _getCitiesUseCase.execute();
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
