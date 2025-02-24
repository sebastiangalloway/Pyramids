import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/task_database.dart';
import '../models/pyramid_brick.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskDatabase = Provider.of<TaskDatabase>(context);
    final bricks = taskDatabase.pyramidBricks;

    return Scaffold(
      body: bricks.isEmpty
          ? Center(child: Text("No bricks yet. Defeat enemies to build!"))
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Pyramid-style layout
                childAspectRatio: 1,
              ),
              itemCount: bricks.length,
              itemBuilder: (context, index) {
                final brick = bricks[index];
                return Card(
                  color: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      brick.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
