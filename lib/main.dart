import 'package:flutter/material.dart';
import 'package:tic_tac_game/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      home: const HomeScreen(),
    );
    return materialApp;
  }
}
