import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pyramid.dart';
import '../models/pyramid_3d_widget.dart';
import '../data/task_database.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final Pyramid pyramid = Pyramid(layers: 4);

  @override
  Widget build(BuildContext context) {
    final taskDatabase = Provider.of<TaskDatabase>(context);
    final bricks = taskDatabase.pyramidBricks;

    return Scaffold(
      body: Column(
        children: [
          // Pyramid 3D widget section
          Container(
            height: 400, // adjust this height as needed
            alignment: Alignment.center,
            child: Pyramid3DView()
          ),
          // Bricks grid view section
          Expanded(
            child: bricks.isEmpty
                ? const Center(
                    child: Text("No bricks yet. Defeat enemies to build!"),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Pyramid-style layout
                      childAspectRatio: 2,
                    ),
                    itemCount: bricks.length,
                    itemBuilder: (context, index) {
                      final brick = bricks[index];
                      return Card(
                        color: const Color.fromARGB(255, 200, 120, 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            brick.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
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
