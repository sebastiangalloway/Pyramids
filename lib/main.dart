import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(PyramidsApp());
}

class PyramidsApp extends StatelessWidget {
  const PyramidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pyramids',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
