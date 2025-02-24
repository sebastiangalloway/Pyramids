import 'package:flutter/material.dart';
import '../game/enemy.dart';

class EnemyWidget extends StatelessWidget {
  final Enemy enemy;
  final VoidCallback onTap;

  const EnemyWidget({required this.enemy, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ✅ Now this will trigger confirmation before attacking
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                enemy.imagePath, // ✅ Load the assigned enemy image
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          const SizedBox(height: 5), // ✅ Add spacing
          Text(
            enemy.name, // ✅ Show the task name under the enemy
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
