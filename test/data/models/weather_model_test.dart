import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/domain/entities/weather.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'Boston',
    main: 'Rain',
    description: 'huge raincloud',
    iconCode: '02d',
    temperature: 209.11,
    pressure: 1009,
    humidity: 70,
  );

  test('should be a subclass of weather entity', () async {
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_weather_response.json'),
    );

    // act
    final result = WeatherModel.fromJson(jsonMap);

    // expect
    expect(result, equals(testWeatherModel));
  });

  test('should return a json map containing proper data', () async {
    // act
    final result = testWeatherModel.toJson();

    // expect

    final expectedJsonMap = {
      'weather': [
        {
          'main': 'Rain',
          'description': 'huge raincloud',
          'icon': '02d',
        }
      ],
      'main': {
        'temp': 209.11,
        'pressure': 1009,
        'humidity': 70,
      },
      'name': 'Boston',
    };

    expect(result, equals(expectedJsonMap));
  });
}
