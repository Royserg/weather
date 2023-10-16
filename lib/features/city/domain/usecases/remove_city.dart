import 'package:weather/features/city/domain/repositories/city_repository.dart';

class RemoveCityUseCase {
  final CityRepository cityRepository;

  const RemoveCityUseCase(this.cityRepository);

  // Either<Failure, Unit> execute(CityEntity city) {
  Future<void> execute(int id) {
    return cityRepository.removeCityById(id);
  }
}
