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
}