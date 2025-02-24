import 'package:flutter/material.dart';
import 'dart:math';

class Enemy {
  String name;
  int difficulty;
  Offset position;
  double speed;
  double angle; // ✅ Used for curved movement

  Enemy({
    required this.name,
    required this.difficulty,
    required this.position,
    double? speed,
    double? angle,
  })  : speed = speed ??
            (Random().nextDouble() * 1.5 + 0.5), // ✅ Unique speed (0.5 - 2.0)
        angle = angle ??
            Random().nextDouble() * 2 * pi; // ✅ Unique movement direction

  void reduceHP() {
    difficulty -= 1;
  }

  bool isDefeated() {
    return difficulty <= 0;
  }

  // ✅ Move smoothly in a circular path
  void move() {
    angle += (Random().nextDouble() - 0.5) *
        0.2; // ✅ Adds slight variation for curves
    position = Offset(
      (position.dx + cos(angle) * speed * 10).clamp(0, 300),
      (position.dy + sin(angle) * speed * 10).clamp(0, 500),
    );
  }
}
