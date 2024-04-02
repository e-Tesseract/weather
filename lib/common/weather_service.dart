// weather_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class WeatherService {
  WeatherService({required this.city});
  final String city;



  static Future<Map<String, dynamic>> getWeatherData() async {

    var sp = await SharedPreferences.getInstance();
    String city = sp.getString('default_city') ?? 'Calais';

    const apiKey = '0f3f2a3eb43bf03802c81919d20927b1';
    final response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final temperatureKelvin = data['main']['temp'];
      final temperatureCelsius = temperatureKelvin.round();
      return {'city': city, 'temperature': temperatureCelsius};
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}