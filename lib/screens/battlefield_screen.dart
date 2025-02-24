import 'dart:math';
import 'package:collection/collection.dart'; // ✅ Add this at the top
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/task_database.dart';
import '../models/game/enemy.dart';

class BattlefieldScreen extends StatefulWidget {
  @override
  _BattlefieldScreenState createState() => _BattlefieldScreenState();
}

class _BattlefieldScreenState extends State<BattlefieldScreen> {
  final Random _random = Random();
  late List<Enemy> _enemies;
  Timer? _movementTimer;

  @override
  void initState() {
    super.initState();
    final taskDatabase = Provider.of<TaskDatabase>(context, listen: false);
    _enemies = taskDatabase.currentTasks.map((task) {
      return Enemy(
        name: task.title,
        difficulty: task.difficulty,
        position: _getRandomPosition(),
      );
    }).toList();
    _animateEnemies();
  }

  Offset _getRandomPosition() {
    return Offset(_random.nextDouble() * 300, _random.nextDouble() * 500);
  }

  void _animateEnemies() {
    _movementTimer?.cancel(); // Stop existing timer if it exists
    _movementTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _enemies = _enemies.map((enemy) {
            return Enemy(
              name: enemy.name,
              difficulty: enemy.difficulty,
              position: Offset(
                (enemy.position.dx + _random.nextDouble() * 50 - 25)
                    .clamp(0, 300),
                (enemy.position.dy + _random.nextDouble() * 50 - 25)
                    .clamp(0, 500),
              ),
            );
          }).toList();
        });
      }
    });
  }

  @override
  void dispose() {
    _movementTimer?.cancel(); // Stop movement updates when screen is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskDatabase = Provider.of<TaskDatabase>(context);

    return Scaffold(
      body: Stack(
        children: _enemies.map((enemy) {
          return AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            left: enemy.position.dx,
            top: enemy.position.dy,
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
                      _enemies.remove(enemy); // Remove defeated enemy
                    });
                  }

                  if (taskToDefeat != null) {
                    taskDatabase.defeatTask(taskToDefeat.id);
                    setState(() {
                      _enemies.remove(enemy); // Remove defeated enemy
                    });
                  }
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
