import 'package:flutter/material.dart';
import 'package:weather/common/weatherMain.dart';
import 'package:weather/routes/home_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/weather_service.dart';



class VillesRoute extends StatelessWidget {
  VillesRoute({Key? key}) : super(key: key);


  final List<String> villes = ['Calais', 'Boulogne', 'Nice']; // Liste des villes

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
          Expanded(
            child: ListView.builder(
              itemCount: villes.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.white70,
                  ),
                  onPressed: () {
                    SharedPreferences.getInstance().then((sp) {
                      sp.setString('default_city', villes[index]);
                      Navigator.pop(context);
                    });
                  },
                  child: Text(villes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}