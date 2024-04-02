import 'package:flutter/material.dart';
import 'package:weather/common/weatherMain.dart';



class VillesRoute extends StatelessWidget {
  VillesRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page de Test'),
      ),
      body: const Center(
        child: Text('Ceci est une page de test'),
      ),
    );
  }
}