import 'package:flutter/material.dart';
import 'package:weather/routes/home_route.dart';

import '../data/dbhelper.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper.initDb();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent
        )
      ),

      home: const HomeRoute()

    );
  }
}
