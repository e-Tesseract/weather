import 'package:flutter/material.dart';
import 'package:weather/common/weatherMain.dart';
import 'package:weather/menu/villes_route.dart';

class MenuRoute extends StatelessWidget {
  const MenuRoute({Key? key}) : super(key: key);
  final int heure = 16;
  final int minute = 30;


  LinearGradient determineBackgroundColor() {
    final Color startColor;
    Color midColor = Colors.blue;
    final Color endColor;

    if (heure < 12) {
      startColor = Color(0xFF508EFF);
      midColor = Color(0xFF173C6E);
      endColor = Color(0xFFFFFABC);
    } else if (heure < 18) {
      startColor = Color(0xFF57ADF3);
      endColor = Color(0xFF99C9E3);
    } else {
      startColor = Color(0xFF030C1E);
      midColor = Color(0xFF173C6E);
      endColor = Color(0xFFFFFABC);
    }

    List<Color> colors;
    if (heure < 12) {
      colors = [startColor, endColor];
    } else if (heure < 18) {
      colors = [startColor, startColor, endColor, endColor, endColor];
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: determineBackgroundColor(),
            ),
          ),
          const WeatherText(),
          const Positioned.fill(
            child: Center(
              child: WeatherMain(),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: <Widget>[
                  const Spacer(), // Utilisation de Spacer pour l'espace entre les 2 boutons
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white, size: 35.0),
                    onPressed: () {
                      // Aller à villes_route.dart
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VillesRoute()),
                      );
                    },
                  ),
                  const Spacer(flex: 100,),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white, size: 35,),
                    onPressed: () {},
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}