import 'package:flutter/material.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class RechercheVilleRoute extends StatefulWidget {
  RechercheVilleRoute({Key? key}) : super(key: key);

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
        title: const Text('Gérer les villes',
            style: TextStyle(color: Colors.white70)),
      ),
      body: Column(
        children: [

          TextField(
            decoration: InputDecoration(
              hintText: 'Recherche...',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (text) async {
              if (text.length >= 3) {
                final csvString =
                    await rootBundle.loadString('assets/villes.csv');
                List<List<dynamic>> csvData =
                    CsvToListConverter().convert(csvString);

                var results = csvData.where((row) {
                  return row[1].toString().startsWith(text);
                }).map((row) {
                  int population = int.tryParse(row[9].toString()) ?? 0;
                  (String, String, String) c = (row[1], row[4], row[7]);
                  return {'city': c, 'population': population};
                }).toList();

                results.sort((a, b) =>
                    (b['population'] as num).compareTo(a['population'] as num));
                print(results.map((result) => result['city']).toList());

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
                (String, String, String) cityInfo =
                    result['city'] as (String, String, String);
                var cityName = cityInfo.$1;
                var country = cityInfo.$2;
                var admin = cityInfo.$3;

                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(cityName, style: TextStyle(color: Colors.white)),
                      Text(country, style: TextStyle(color: Colors.white70)),
                      Text(admin, style: TextStyle(color: Colors.white70)),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {

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
}
