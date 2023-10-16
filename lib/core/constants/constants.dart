class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  static const String apiKey = '0e5475018ddb8055febea2feca80edd2';

  static String currentWeatherByName(String cityName) =>
      '$baseUrl/weather?q=$cityName&appid=$apiKey';

  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
