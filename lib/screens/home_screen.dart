import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pyramids")),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/tasks');
            },
            child: Text("Tasks"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/progress');
            },
            child: Text("Progress"),
          ),
        ],
      ),
    );
  }
}
