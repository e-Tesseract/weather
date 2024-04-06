import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/menu/recherche_ville.dart';
import 'package:weather/data/dbhelper.dart';
import 'package:weather/data/ville_dto.dart';

class VillesRoute extends StatefulWidget {
  VillesRoute({Key? key}) : super(key: key);

  @override
  _VillesRouteState createState() => _VillesRouteState();
}

class _VillesRouteState extends State<VillesRoute> {
  List<VilleDTO> villes = [];

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
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RechercheVilleRoute()),
              );

              fetchVilles();
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: villes.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(villes[index].id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.0),
                    color: Colors.red,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) async {

                    if(villes[index].id == null) return;

                    await DBHelper.delete(villes[index].id!);
                    setState(() {
                      villes.removeAt(index);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        SharedPreferences.getInstance().then((sp) {
                          sp.setString('default_city', villes[index].name);
                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        minimumSize: Size(double.infinity, 48),
                      ),
                      child: Text(villes[index].name),
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
}
