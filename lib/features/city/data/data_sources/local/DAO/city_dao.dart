import 'package:floor/floor.dart';
import 'package:weather/features/city/data/models/city_model.dart';

@dao
abstract class CityDao {
  @Insert()
  Future<void> insertCity(CityModel city);

  @Query('DELETE * FROM cities where id = :id')
  Future<void> deleteCityById(int id);

  @Query('SELECT * FROM cities')
  Future<List<CityModel>> getCities();
}
