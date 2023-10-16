class Urls {
  // -- Open Meteo API
  static const String geocodingOpenMeteoBaseUrl =
      'https://geocoding-api.open-meteo.com/v1/';
  static String searchCity(String query) =>
      '$geocodingOpenMeteoBaseUrl/search?language=en&count=5&format=json&name=$query';

  static const String weatherOpenMeteoBaseUrl =
      'https://api.open-meteo.com/v1/';
  static String weatherByLatLong(double latitude, double longitude) =>
      '$weatherOpenMeteoBaseUrl/forecast?latitude=$latitude&longitude=$longitude&current=temperature_2m,apparent_temperature,precipitation,weathercode&hourly=temperature_2m,weathercode,is_day&timezone=auto';
}
