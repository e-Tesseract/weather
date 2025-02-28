// weather_text.dart
import 'package:flutter/material.dart';
import 'weather_service.dart';

class WeatherText extends StatelessWidget {
  const WeatherText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.5), // Increase bottom padding
      child: Align(
        alignment: Alignment.topCenter,
        child: FutureBuilder<Map<String, dynamic>>(
          future: WeatherService.getWeatherData(),
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
                    '${snapshot.data?['city']}'.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      '${snapshot.data?['temperature']}°',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 100,
                        fontWeight: FontWeight.w900,
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