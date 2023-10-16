import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/core/constants/constants.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/features/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(double latitude, double longitude);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(
      double latitude, double longitude) async {
    final response =
        await client.get(Uri.parse(Urls.weatherByLatLong(latitude, longitude)));

    if (response.statusCode == 200) {
      final weather = WeatherModel.fromJson(json.decode(response.body));
      return weather;
    } else {
      throw ServerException();
    }
  }
}
