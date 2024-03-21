import 'package:flutter/material.dart';

class MenuRoute extends StatelessWidget {
  const MenuRoute({Key? key}) : super(key: key);
  final int heure = 17;
  final int minute = 30;

  Color determineBackgroundColor() {
    if (heure < 18) {
      return Colors.blue;
    } else {
      return Colors.white10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: determineBackgroundColor(),
      body: Stack(
        children: [
          Container(
            // COntenu de la page
          ),
          Positioned(
           bottom: -200,
            left: MediaQuery.of(context).size.width / 800,
            child: SizedBox(
              height: 700.0, // Définir la hauteur
              width: MediaQuery.of(context).size.width * 1, // Définir la largeur
              child: Image.asset(
                'assets/montagne.jpg',
                fit: BoxFit.fitHeight,

              ),
            ),
          ),
        ],

      ),
    );
  }
}