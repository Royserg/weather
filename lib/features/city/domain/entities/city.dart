import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  const CityEntity({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.countryCode,
  });

  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final String countryCode;

  @override
  List<Object?> get props => [
        id,
        name,
        latitude,
        longitude,
        country,
        countryCode,
      ];
}
