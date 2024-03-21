import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherText extends StatelessWidget {
  const WeatherText({Key? key}) : super(key: key);

  Future<String> getWeatherData() async {
  const apiKey = '0f3f2a3eb43bf03802c81919d20927b1';
  const city = 'Calais';
  final response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final temperatureKelvin = data['main']['temp'];
    final temperatureCelsius = temperatureKelvin; // Convert to Celsius
    return 'Temperature in $city: ${temperatureCelsius.toStringAsFixed(2)}°C'; // Display with 2 decimal places
  } else {
    throw Exception('Failed to load weather data');
  }
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getWeatherData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('Loaded: ${snapshot.data}');
        }
      },
    );
  }
}