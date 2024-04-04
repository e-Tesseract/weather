import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/menu/recherche_ville.dart';

class VillesRoute extends StatefulWidget {
  VillesRoute({Key? key}) : super(key: key);

  @override
  _VillesRouteState createState() => _VillesRouteState();
}

class _VillesRouteState extends State<VillesRoute> {
  final List<String> villes = ['Calais', 'Boulogne', 'Nice'];

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
                return Dismissible(
                  key: Key(villes[index]),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      villes.removeAt(index);
                      _saveCitiesToSharedPreferences();
                    });
                  },
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        onPrimary: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 80),
                      ),
                      onPressed: () {
                        SharedPreferences.getInstance().then((sp) {
                          sp.setString('default_city', villes[index]);
                          Navigator.pop(context);
                        });
                      },
                      child: Text(villes[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour enregistrer les villes mises à jour dans SharedPreferences
  _saveCitiesToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cities', villes);
  }
}
