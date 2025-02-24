import 'package:flutter/material.dart';
import 'enemy.dart';

class EnemyWidget extends StatelessWidget {
  final Enemy enemy;
  final VoidCallback onTap;

  const EnemyWidget({required this.enemy, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ✅ Attack enemy when tapped
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle, // ✅ Makes enemy a circle
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "⚔️ ${enemy.name}",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "HP: ${enemy.difficulty * 10}",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
