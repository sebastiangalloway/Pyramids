import 'package:flutter/material.dart';

class PyramidBlock {
  final int layer;
  final int row;
  final int col;
  final Color color;

  PyramidBlock({
    required this.layer,
    required this.row,
    required this.col,
    required this.color,
  });
}

class Pyramid {
  late final int layers;
  final List<PyramidBlock> blocks;

  Pyramid({required this.layers}) : blocks = [] {
    _generateBlocks();
  }

  void _generateBlocks() {
    blocks.clear();
    for (int layer = 0; layer < layers; layer++) {
      final int blocksPerSide = layers - layer;
      for (int row = 0; row < blocksPerSide; row++) {
        for (int col = 0; col < blocksPerSide; col++) {
          blocks.add(PyramidBlock(
            layer: layer,
            row: row,
            col: col,
            color: Colors.primaries[(layer + row + col) % Colors.primaries.length],
          ));
        }
      }
    }
  }

  void addLayer() {
    layers += 1;
    _generateBlocks();
  }

  PyramidBlock? getBlock(int layer, int row, int col) {
    try {
      return blocks.firstWhere(
        (b) => b.layer == layer && b.row == row && b.col == col,
      );
    } catch (e) {
      return null;
    }
  }
}