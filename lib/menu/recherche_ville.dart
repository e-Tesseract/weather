import 'package:flutter/material.dart';
import 'package:weather/common/weatherMain.dart';


import 'package:flutter/material.dart';
import 'package:weather/common/weatherMain.dart';

class RechercheVilleRoute extends StatelessWidget {
  RechercheVilleRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white70, size: 35),
            title: const Text('Gérer les villes', style: TextStyle(color: Colors.white70)),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Recherche...',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (text) {
              if (text.length >= 3) {
                // L'utilisateur a saisi au moins 3 lettres, vous pouvez déclencher une action ici
              }
            },
          ),
        ],
      ),
    );
  }
}