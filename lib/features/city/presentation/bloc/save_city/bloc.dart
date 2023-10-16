import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/city/domain/usecases/save_city.dart';
import 'package:weather/features/city/presentation/bloc/save_city/event.dart';
import 'package:weather/features/city/presentation/bloc/save_city/state.dart';

class CitySaveBloc extends Bloc<CitySaveEvent, CitySaveState> {
  final SaveCityUseCase _saveCityUseCase;

  CitySaveBloc(this._saveCityUseCase) : super(CitySaveEmpty()) {
    on<OnCitySave>((event, emit) async {
      emit(CitySaveLoading());

      final result = await _saveCityUseCase.execute(event.city);
      result.fold((failure) {
        emit(CitySaveFailure());
      }, (data) {
        emit(CitySaveSuccess());
      });
    });
  }
}
