import 'package:floor/floor.dart';
import 'package:weather/features/city/data/data_sources/local/DAO/city_dao.dart';
import 'package:weather/features/city/data/models/city_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'app_database.g.dart';

@Database(version: 1, entities: [CityModel])
abstract class AppDatabase extends FloorDatabase {
  CityDao get cityDao;
}
