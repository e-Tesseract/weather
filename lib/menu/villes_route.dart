import 'package:flutter/material.dart';
import 'package:weather/common/weatherMain.dart';



class VillesRoute extends StatelessWidget {
  VillesRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Gérer les villes'),
      ),
      body: const Center(
        child: Text('Ceci est une page de test'),
      ),
    );
  }
}