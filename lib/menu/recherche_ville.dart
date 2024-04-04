import 'package:flutter/material.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import '../data/dbhelper.dart';
import '../data/ville_dto.dart';

class RechercheVilleRoute extends StatefulWidget {
  const RechercheVilleRoute({Key? key}) : super(key: key);

  @override
  State<RechercheVilleRoute> createState() => _RechercheVilleRouteState();
}

class _RechercheVilleRouteState extends State<RechercheVilleRoute> {
  List<Map<String, dynamic>> filteredCities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white70, size: 35),
        title: const Text('Gérer les villes', style: TextStyle(color: Colors.white70)),
      ),
      body: Column(
        children: [
          TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: 'Recherche...',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (text) async {
              if (text.length >= 3) {
                final csvString = await rootBundle.loadString('assets/villes.csv');
                List<List<dynamic>> csvData = CsvToListConverter().convert(csvString);

                var results = csvData.where((row) {
                  return row[1].toString().toLowerCase().startsWith(text.toLowerCase());
                }).map((row) {
                  int population = int.tryParse(row[9].toString()) ?? 0;
                  (String, String, String) c = (row[1], row[4], row[7]);
                  return {'city': c, 'population': population};
                }).toList();

                results.sort((a, b) => (b['population'] as num).compareTo(a['population'] as num));

                setState(() {
                  filteredCities = results;
                });
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCities.length,
              itemBuilder: (context, index) {
                var result = filteredCities[index];
                (String, String, String) cityInfo = result['city'] as (String, String, String);
                var cityName = cityInfo.$1;
                var country = cityInfo.$2;
                var admin = cityInfo.$3;

                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(cityName, style: TextStyle(color: Colors.white)),
                          Row(
                            children: <Widget>[
                              Text(country, style: TextStyle(color: Colors.white70)),
                              Text(', ', style: TextStyle(color: Colors.white70)),
                              Text(admin, style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.white,
                        onPressed: () {
                          _addCityToDatabase(cityName);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // Fonction pour ajouter la ville à la base de données
  // Dans la méthode _addCityToDatabase, modifiez l'appel de la méthode insert pour récupérer l'ID de la ville insérée
  void _addCityToDatabase(String cityName) async {
    DBHelper dbHelper = DBHelper();
    int id = await DBHelper.insertVille(VilleDTO(name: cityName, id: null));
    VilleDTO ville = VilleDTO(id: id, name: cityName);
  }

}
