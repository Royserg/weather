class WmoWeatherCodeConverter {
  static String convert(int code) {
    switch (code) {
      case 0:
        return 'Clear sky';
      case 1:
        return 'Mainly clear';
      case 2:
        return 'Partly cloudy';
      case 3:
        return 'Overcast';
      case 45:
      case 48:
        return 'Fog';
      case 51:
        return 'Light drizzle';
      case 53:
        return 'Moderate drizzle';
      case 55:
        return 'Heavy drizzle';
      case 56:
        return "Light freezing drizzle";
      case 57:
        return "Heavy freezing drizzle";
      case 61:
        return "Slight rain";
      case 63:
        return "Moderate rain";
      case 65:
        return "Heavy rain";
      case 66:
        return "Freezing rain";
      case 67:
        return "Heavy freezing rain";
      case 71:
        return "Slight snow fall";
      case 73:
        return "Moderate snow fall";
      case 75:
        return "Heavy snow fall";
      case 77:
        return "Snow grains";
      case 80:
        return "Slight rain showers";
      case 81:
        return "Moderate rain showers";
      case 82:
        return "Violent rain showers";
      case 85:
        return "Slight snow showers";
      case 86:
        return "Heavy snow showers";
      case 95:
        return "Thunderstorm";
      case 96:
      case 99:
        return "Thunderstorm with hail";
      default:
        return 'Unknown';
    }
  }
}
