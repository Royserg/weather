import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/city/domain/usecases/remove_city.dart';
import 'package:weather/features/city/presentation/bloc/delete_city/event.dart';
import 'package:weather/features/city/presentation/bloc/delete_city/state.dart';

class CityDeleteBloc extends Bloc<CityDeleteEvent, CityDeleteState> {
  final RemoveCityUseCase _removeCityUseCase;

  CityDeleteBloc(this._removeCityUseCase) : super(CityDeleteEmpty()) {
    on<OnCityDelete>((event, emit) async {
      emit(CityDeleteLoading());

      final result = await _removeCityUseCase.execute(event.id);
      result.fold((failure) {
        emit(CityDeleteFailure());
      }, (data) {
        emit(CityDeleteSuccess());
      });
    });
  }
}
