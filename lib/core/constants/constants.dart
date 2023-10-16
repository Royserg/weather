class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/';
  static const String apiKey = '609d67ae9abbd3612ae2f78e17da52e9';
  static String currentWeatherByName(String cityName) =>
      '$baseUrl/weather?q=$cityName&appid=$apiKey&units=metric';

  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';

  // -- Open Meteo API
  static const String GeocodingOpenMeteoBaseUrl =
      'https://geocoding-api.open-meteo.com/v1/';
  static String searchCity(String query) =>
      '$GeocodingOpenMeteoBaseUrl/search?language=en&count=5&format=json&name=$query';
}
