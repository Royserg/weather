import 'package:floor/floor.dart';
import 'package:weather/features/city/domain/entities/city.dart';

@Entity(tableName: 'cities', primaryKeys: ['id'])
class CityModel extends CityEntity {
  const CityModel({
    required int id,
    required String name,
    required double latitude,
    required double longitude,
    required String country,
    required String countryCode,
  }) : super(
          id: id,
          name: name,
          latitude: latitude,
          longitude: longitude,
          country: country,
          countryCode: countryCode,
        );

  factory CityModel.fromEntity(CityEntity entity) => CityModel(
        id: entity.id,
        name: entity.name,
        latitude: entity.latitude,
        longitude: entity.longitude,
        country: entity.country,
        countryCode: entity.countryCode,
      );

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json['id'],
        name: json['name'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        country: json['country'],
        countryCode: json['country_code'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'country': country,
        'country_code': countryCode,
      };

  CityEntity toEntity() => CityEntity(
        id: id,
        name: name,
        latitude: latitude,
        longitude: longitude,
        country: country,
        countryCode: countryCode,
      );
}
