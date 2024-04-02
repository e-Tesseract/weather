// weatherText.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles/weather_text.dart';
import 'weather_service.dart';


class WeatherMain extends StatelessWidget {
  const WeatherMain({Key? key, this.weatherUpdatedAt}) : super(key: key);

  final DateTime? weatherUpdatedAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.5),
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
                    style: cityTextStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      '${snapshot.data?['temperature']}°',
                      style: temperatureTextStyle,
                    ),
                  ),
                  Text(
                    '${snapshot.data?['weatherDescription']}',
                    style: const TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}