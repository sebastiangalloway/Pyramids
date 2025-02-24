import 'package:flutter/material.dart';

class Enemy {
  String name;
  int difficulty;
  Offset position;

  Enemy({required this.name, required this.difficulty, required this.position});

  void reduceHP() {
    difficulty -= 1;
  }

  bool isDefeated() {
    return difficulty <= 0;
  }
}

class EnemyWidget extends StatelessWidget {
  final Enemy enemy;
  final VoidCallback onTap;

  const EnemyWidget({required this.enemy, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("⚔️ ${enemy.name}",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text("HP: ${enemy.difficulty * 10}",
                style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
