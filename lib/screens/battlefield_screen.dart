import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/task_database.dart';

class BattlefieldScreen extends StatefulWidget {
  @override
  _BattlefieldScreenState createState() => _BattlefieldScreenState();
}

class _BattlefieldScreenState extends State<BattlefieldScreen> {
  Map<int, bool> isAttackedMap = {}; // Track attack animations per enemy

  @override
  Widget build(BuildContext context) {
    final taskDatabase = Provider.of<TaskDatabase>(context);
    final tasks = taskDatabase.currentTasks;

    return Scaffold(
      body: tasks.isEmpty
          ? Center(child: Text("No enemies yet! Add tasks to spawn them."))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                // Initialize attack state
                isAttackedMap[task.id] ??= false;

                return AnimatedContainer(
                  duration: Duration(milliseconds: 300), // Faster flash effect
                  color: isAttackedMap[task.id]!
                      ? Colors.redAccent.withOpacity(0.5) // Brief flash
                      : Colors.transparent, // Normal state
                  child: ListTile(
                    title: Text("⚔️ ${_generateEnemyName(task.title)}"),
                    subtitle: Text("HP: ${task.difficulty * 10}"),
                    trailing: IconButton(
                      icon:
                          Icon(Icons.local_fire_department, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          isAttackedMap[task.id] = true; // Trigger red flash
                        });

                        Future.delayed(Duration(milliseconds: 300), () {
                          setState(() {
                            isAttackedMap[task.id] = false; // Reset flash
                          });
                        });

                        setState(() {
                          task.difficulty -= 1;
                        });

                        if (task.difficulty <= 0) {
                          taskDatabase.deleteTask(task.id);
                        }
                      },
                    ),
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
