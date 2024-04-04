import 'package:flutter/material.dart';
import 'package:weather/common/weatherMain.dart';
import 'package:weather/routes/home_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/menu/recherche_ville.dart';
import 'package:weather/data/DBHelper.dart'; // Import DBHelper
import 'package:weather/data/ville_dto.dart'; // Import VilleDTO

import '../common/weather_service.dart';

class VillesRoute extends StatefulWidget {
  VillesRoute({Key? key}) : super(key: key);

  @override
  _VillesRouteState createState() => _VillesRouteState();
}
class _VillesRouteState extends State<VillesRoute> {
  List<VilleDTO> villes = []; // Liste des villes

  @override
  void initState() {
    super.initState();
    fetchVilles();
  }

  fetchVilles() async {
    villes = await DBHelper.findAll();
    setState(() {});
  }

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
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Ajouter des villes...',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RechercheVilleRoute()),
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: villes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(villes[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}