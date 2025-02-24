import 'package:flutter/material.dart';
import 'dart:math';

class Enemy {
  String name;
  int difficulty;
  Offset position;
  double speed;
  double angle;
  String imagePath; // ✅ Stores the randomly assigned enemy image

  Enemy({
    required this.name,
    required this.difficulty,
    required this.position,
    double? speed,
    double? angle,
    String? imagePath,
  })  : speed = speed ?? (Random().nextDouble() * 1.5 + 0.5),
        angle = angle ?? Random().nextDouble() * 2 * pi,
        imagePath =
            imagePath ?? _getRandomOrkImage(); // ✅ Random image selection

  void reduceHP() {
    difficulty -= 1;
  }

  bool isDefeated() {
    return difficulty <= 0;
  }

  void move() {
    angle += (Random().nextDouble() - 0.5) * 0.2;
    position = Offset(
      (position.dx + cos(angle) * speed * 10).clamp(0, 300),
      (position.dy + sin(angle) * speed * 10).clamp(0, 500),
    );
  }

  // ✅ Randomly select one of three Ork images
  static String _getRandomOrkImage() {
    List<String> orkImages = [
      'assets/enemies/1_ORK/ATTAK/ATTAK_002.png',
      'assets/enemies/2_ORK/ATTAK/ATTAK_002.png',
      'assets/enemies/3_ORK/ATTAK/ATTAK_002.png',
    ];
    return orkImages[Random().nextInt(orkImages.length)];
  }
}
