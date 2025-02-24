import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/task_database.dart';
import '../models/game/enemy.dart';
import '../models/game/enemy_widget.dart';
import 'package:collection/collection.dart';

class BattlefieldScreen extends StatefulWidget {
  @override
  _BattlefieldScreenState createState() => _BattlefieldScreenState();
}

class _BattlefieldScreenState extends State<BattlefieldScreen> {
  final Random _random = Random();
  late List<Enemy> _enemies;
  final Map<Enemy, Timer> _enemyTimers = {};

  @override
  void initState() {
    super.initState();
    final taskDatabase = Provider.of<TaskDatabase>(context, listen: false);

    _enemies = taskDatabase.currentTasks.map((task) {
      return Enemy(
        name: task.title, // ✅ Task name appears under the enemy
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
        Duration(milliseconds: (1000 ~/ (enemy.difficulty + 1))),
        (timer) {
          if (!mounted) return;

          setState(() {
            enemy.move();
          });
        },
      );
    }
  }

  @override
  void dispose() {
    for (var timer in _enemyTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }

  // ✅ Show Confirmation Dialog Before Attacking
  void _confirmAttack(BuildContext context, Enemy enemy) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Attack ${enemy.name}?"),
          content: Text(
              "Do you want to attack this enemy and complete the task '${enemy.name}'?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // ❌ Cancel
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _attackEnemy(enemy); // ✅ Attack if confirmed
              },
              child: Text("Attack"),
            ),
          ],
        );
      },
    );
  }

  void _attackEnemy(Enemy enemy) {
    final taskDatabase = Provider.of<TaskDatabase>(context, listen: false);

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
          _enemyTimers[enemy]?.cancel();
          _enemies.remove(enemy);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _enemies.map((enemy) {
          return TweenAnimationBuilder<Offset>(
            key: ValueKey(enemy.name),
            tween: Tween<Offset>(begin: enemy.position, end: enemy.position),
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            builder: (context, position, child) {
              return Positioned(
                left: position.dx,
                top: position.dy,
                child: EnemyWidget(
                  enemy: enemy,
                  onTap: () => _confirmAttack(context,
                      enemy), // ✅ Ask for confirmation before attacking
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
