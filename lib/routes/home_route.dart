import 'package:flutter/material.dart';

class MenuRoute extends StatelessWidget {
  const MenuRoute({Key? key}) : super(key: key);
  final int heure = 17;
  final int minute = 30;

  Color determineBackgroundColor() {
    if (heure < 18) {
      return Colors.blue;
    } else {
      return Colors.white10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: determineBackgroundColor(),
    );
  }
}