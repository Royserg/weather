import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/core/constants/constants.dart';
import 'package:weather/core/error/exception.dart';
import 'package:weather/features/city/data/models/city_model.dart';

abstract class CityRemoteDataSource {
  Future<List<CityModel>> searchCity(String query);
}

class CityRemoteDataSourceImpl extends CityRemoteDataSource {
  final http.Client client;
  CityRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CityModel>> searchCity(String query) async {
    final response = await client.get(Uri.parse(Urls.searchCity(query)));

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final parsedRes = SearchCityResponse.fromJson(res);

      return parsedRes.results;
    } else {
      throw ServerException();
    }
  }
}

// Response interface
class SearchCityResponse {
  SearchCityResponse({
    required this.results,
  });

  late List<CityModel> results;

  SearchCityResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <CityModel>[];
      json['results'].forEach((city) {
        results.add(CityModel.fromJson(city));
      });
    }
  }
}
