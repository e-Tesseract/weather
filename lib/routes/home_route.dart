import 'package:flutter/material.dart';
import 'package:weather/common/weatherText.dart';

class MenuRoute extends StatelessWidget {
  const MenuRoute({Key? key}) : super(key: key);
  final int heure = 18;
  final int minute = 30;

  LinearGradient determineBackgroundColor() {
    final Color startColor;
    Color midColor = Colors.blue;
    final Color endColor;

    if (heure < 12) {
      startColor = Color(0xFF6DB8FF);
      endColor = Color(0xFFFDE3BB);
    } else if (heure < 18) {
      startColor = Color(0xFF508EFF);
      midColor = Color(0xFF173C6E);
      endColor = Color(0xFFFFFABC);
    } else {
      startColor = Color(0xFF030C1E);
      midColor = Color(0xFF173C6E);
      endColor = Color(0xFFFFFABC);
    }

    List<Color> colors;
    if (heure < 12) {
      colors = [startColor, startColor, endColor, endColor, endColor];
    } else if (heure < 18) {
      colors = [startColor, endColor];
    } else {
      colors = [startColor, startColor, midColor, endColor];
    }

    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colors,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: <Widget>[
            const Spacer(), // Utilisation de Spacer pour l'espace entre les 2 boutons
            IconButton(
              icon: const Icon(Icons.cloud, color: Colors.white),
              onPressed: () {

              },
            ),
            const Spacer(flex: 1,),
            IconButton(
              icon: const Icon(Icons.location_city, color: Colors.white),
              onPressed: () {

              },
            ),
            const Spacer(),
          ],
        ),
      ),
      body: Stack(
        children: [
          const WeatherText(),
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