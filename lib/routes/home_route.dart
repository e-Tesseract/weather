import 'package:flutter/material.dart';
import 'package:weather/common/weatherText.dart';

class MenuRoute extends StatelessWidget {
  const MenuRoute({Key? key}) : super(key: key);
  final int heure = 18;
  final int minute = 30;

  LinearGradient determineBackgroundColor() {
    final Color startColor;
    final Color endColor;

    if (heure < 12) {
      startColor = Colors.blueAccent;
      endColor = Colors.orangeAccent;
    } else if (heure < 16) {
      startColor = Colors.lightBlue;
      endColor = Colors.blue;
    } else {
      startColor = Colors.black;
      endColor = Colors.blue;
    }

    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [startColor, endColor],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                gradient: determineBackgroundColor(),
              )
          ),
          const Positioned.fill(
            child: Center(
              child: WeatherText(),
            ),
          ),
          if (heure < 16)
            Positioned(
              bottom: -200,
              left: MediaQuery.of(context).size.width / 800,
              child: SizedBox(
                height: 820.0, // Définir la hauteur
                width: MediaQuery.of(context).size.width * 1, // Définir la largeur
                child: Image.asset(
                  'assets/montagne2.jpg',
                  fit: BoxFit.fitHeight,

                ),
              ),
            ),
          if (heure < 16)
            Positioned(
              bottom: -200,
              left: MediaQuery.of(context).size.width / 800,
              child: SizedBox(
                height: 620.0, // Définir la hauteur
                width: MediaQuery.of(context).size.width * 1, // Définir la largeur
                child: Image.asset(
                  'assets/montagne2.jpg',
                  fit: BoxFit.fitHeight,

                ),
              ),
            ),
          if (heure >= 16)
            Positioned(
              bottom: -200,
              left: MediaQuery.of(context).size.width / 800,
              child: SizedBox(
                height: 825.0, // Définir la hauteur
                width: MediaQuery.of(context).size.width * 1, // Définir la largeur
                child: Image.asset(
                  'assets/foretnuit.png',
                  fit: BoxFit.fitHeight,

                ),
              ),
            ),

        ],

      ),
    );
  }
}