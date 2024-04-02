// weather_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  Future<Map<String, dynamic>> getWeatherData() async {
    const apiKey = '0f3f2a3eb43bf03802c81919d20927b1';
    const city = 'Calais';
    final response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=fr'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final temperatureKelvin = data['main']['temp'];
      final temperatureCelsius = temperatureKelvin.round();
      final weatherDescription = data['weather'][0]['description'];
      return {'city': city, 'temperature': temperatureCelsius, 'weatherDescription': weatherDescription};
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Map<String, dynamic>>> getLongTermForecast() async {
    const apiKey = '0f3f2a3eb43bf03802c81919d20927b1';
    const city = 'Calais'; // Replace with your city name

    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric&lang=fr')); // Use city name instead of city ID

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final longTermForecasts = List<Map<String, dynamic>>.from(
        data['list'].map((forecast) {

          final forecastDate = DateTime.parse(forecast['dt_txt']);
          final dayOfWeek = _getDayOfWeek(forecastDate.weekday);
          final weatherIcon = _getWeatherIcon(forecast['weather'][0]['icon']);
          final minTemp = forecast['main']['temp_min'];
          final maxTemp = forecast['main']['temp_max'];

          return {
            'dayOfWeek': dayOfWeek,
            'weatherIcon': weatherIcon,
            'minTemp': minTemp,
            'maxTemp': maxTemp,
          };
        }),
      );

      final uniqueDays = longTermForecasts.fold<List<Map<String, dynamic>>>([], (previous, current) {
        final previousDay = previous.isNotEmpty ? previous.last['dayOfWeek'] : null;

        if (current['dayOfWeek'] != previousDay) {
          previous.add(current);
        }
        return previous;
      });

      return uniqueDays.take(3).toList();
    } else {
      throw Exception('Failed to load long-term forecast');
    }
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Lun';
      case DateTime.tuesday:
        return 'Mar';
      case DateTime.wednesday:
        return 'Mer';
      case DateTime.thursday:
        return 'Jeu';
      case DateTime.friday:
        return 'Ven';
      case DateTime.saturday:
        return 'Sam';
      case DateTime.sunday:
        return 'Dim';
      default:
        return '';
    }
  }

  String _getWeatherIcon(String iconCode) {
    return 'http://openweathermap.org/img/wn/$iconCode.png';
  }
}