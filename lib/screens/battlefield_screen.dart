import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Missing import?
import '../data/task_database.dart'; // Import your database functions

class BattlefieldScreen extends StatefulWidget {
  @override
  _BattlefieldScreenState createState() => _BattlefieldScreenState();
}

class _BattlefieldScreenState extends State<BattlefieldScreen> {

  @override
  Widget build(BuildContext context) {
    final taskDatabase = Provider.of<TaskDatabase>(context);
    final tasks = taskDatabase.currentTasks; // Get tasks from Provider
    return Scaffold(
      body: tasks.isEmpty
          ? Center(child: Text("No enemies yet! Add tasks to spawn them."))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text("⚔️ ${_generateEnemyName(task.title)}"),
                  subtitle: Text("HP: ${task.difficulty * 10}"), 
                  trailing: IconButton(
                    icon: Icon(Icons.local_fire_department, color: Colors.red), // Attack icon
                    onPressed: () {
                      setState(() {
                        task.difficulty -= 1; // Decrease difficulty (HP)
                      });

                      if (task.difficulty <= 0) {
                        taskDatabase.deleteTask(task.id); // Remove defeated enemy
                      }
                    },
                  ),
                );
              },
            ),
    );
  }

  String _generateEnemyName(String taskTitle) {
    List<String> enemyPrefixes = ["Shadow", "Doom", "Fiery", "Cursed"];
    List<String> enemyTypes = ["Goblin", "Beast", "Knight", "Specter"];
    return "${enemyPrefixes[taskTitle.length % enemyPrefixes.length]} ${enemyTypes[taskTitle.length % enemyTypes.length]}";
  }
}
