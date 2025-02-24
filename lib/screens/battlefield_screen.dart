import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/task_database.dart';
import 'package:collection/collection.dart'; // ✅ Add this at the top
import '../models/game/enemy.dart';
import '../models/game/enemy_widget.dart'; // ✅ Import the new EnemyWidget

class BattlefieldScreen extends StatefulWidget {
  @override
  _BattlefieldScreenState createState() => _BattlefieldScreenState();
}

class _BattlefieldScreenState extends State<BattlefieldScreen> {
  final Random _random = Random();
  late List<Enemy> _enemies;
  final Map<Enemy, Timer> _enemyTimers = {}; // ✅ Separate timers per enemy

  @override
  void initState() {
    super.initState();
    final taskDatabase = Provider.of<TaskDatabase>(context, listen: false);

    // ✅ Create enemies with unique speeds & starting angles
    _enemies = taskDatabase.currentTasks.map((task) {
      return Enemy(
        name: task.title,
        difficulty: task.difficulty,
        position: _getRandomPosition(),
      );
    }).toList();

    _startEnemyMovements();
  }

  Offset _getRandomPosition() {
    return Offset(_random.nextDouble() * 300, _random.nextDouble() * 500);
  }

  void _startEnemyMovements() {
    for (var enemy in _enemies) {
      _enemyTimers[enemy] = Timer.periodic(
        Duration(milliseconds: (1000 ~/ (enemy.difficulty + 1))), // ✅ Speed based on difficulty
        (timer) {
          if (!mounted) return;

          setState(() {
            enemy.move(); // ✅ Uses curved movement logic
          });
        },
      );
    }
  }

  @override
  void dispose() {
    for (var timer in _enemyTimers.values) {
      timer.cancel(); // ✅ Stop all enemy movement timers
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskDatabase = Provider.of<TaskDatabase>(context);

    return Scaffold(
      body: Stack(
        children: _enemies.map((enemy) {
          return TweenAnimationBuilder<Offset>(
            key: ValueKey(enemy.name), // ✅ Ensures animations are unique per enemy
            tween: Tween<Offset>(begin: enemy.position, end: enemy.position),
            duration: Duration(milliseconds: 600), // ✅ Slower transition for smooth effect
            curve: Curves.easeInOut, // ✅ Adds fluidity
            builder: (context, position, child) {
              return Positioned(
                left: position.dx,
                top: position.dy,
                child: EnemyWidget(
                  enemy: enemy,
                  onTap: () {
                    setState(() {
                      enemy.reduceHP();
                    });

                    if (enemy.isDefeated()) {
                      final taskToDefeat = taskDatabase.currentTasks.firstWhereOrNull(
                        (t) => t.title == enemy.name,
                      );

                      if (taskToDefeat != null) {
                        taskDatabase.defeatTask(taskToDefeat.id);
                        setState(() {
                          _enemyTimers[enemy]?.cancel(); // ✅ Stop this enemy's movement
                          _enemies.remove(enemy); // ✅ Remove defeated enemy
                        });
                      }
                    }
                  },
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}