import 'package:flutter/material.dart';
import 'package:weather/common/weatherMain.dart';



class RechercheVilleRoute extends StatelessWidget {
  RechercheVilleRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Text('Ceci est une page de test recherche', style: TextStyle(color: Colors.white70)),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            // Changer la couleur de l'icon
            iconTheme: const IconThemeData(color: Colors.white70, size: 35),
            title: const Text('Paramètres', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}