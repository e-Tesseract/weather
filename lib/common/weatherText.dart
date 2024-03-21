import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherText extends StatelessWidget {
  const WeatherText({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> getWeatherData() async {
    const apiKey = '0f3f2a3eb43bf03802c81919d20927b1';
    const city = 'Calais';
    final response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final temperatureKelvin = data['main']['temp'];
      final temperatureCelsius = temperatureKelvin.round(); // Round to nearest whole number
      return {'city': city, 'temperature': temperatureCelsius}; // Return city and temperature
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.5), // Increase bottom padding
      child: Align(
        alignment: Alignment.topCenter, // Align to the top of the screen
        child: FutureBuilder<Map<String, dynamic>>(
          future: getWeatherData(),
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${snapshot.data?['city']}'.toUpperCase(), // Convert city to uppercase
                    style: const TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0), // Add left padding
                    child: Text(
                      '${snapshot.data?['temperature']}°', // Display rounded temperature
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 100,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}