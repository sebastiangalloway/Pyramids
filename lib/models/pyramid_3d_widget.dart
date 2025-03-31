import 'package:flutter/material.dart';
import 'pyramid.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:vector_math/vector_math_64.dart' as VectorMath;

class Pyramid3DView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Cube(
      onSceneCreated: (Scene scene) {
        scene.world.add(Object(
          scale: VectorMath.Vector3(1.0, 1.0, 1.0),
          position: VectorMath.Vector3(0, 0, 0),
          fileName:
              'assets/pyramid_model.obj', // Ensure you have a proper 3D model here
        ));
        scene.camera.zoom = 10;
      },
    );
  }
}

class Pyramid3DWidget extends StatefulWidget {
  final double blockSize;
  final Pyramid pyramid;

  const Pyramid3DWidget({
    Key? key,
    required this.blockSize,
    required this.pyramid,
  }) : super(key: key);

  @override
  _Pyramid3DWidgetState createState() => _Pyramid3DWidgetState();
}

class _Pyramid3DWidgetState extends State<Pyramid3DWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.blockSize * widget.pyramid.layers,
      height: widget.blockSize * widget.pyramid.layers,
      child: Stack(
        alignment: Alignment.center,
        children: widget.pyramid.blocks.map(_buildBlock).toList(),
      ),
    );
  }

  Widget _buildBlock(PyramidBlock block) {
    final double offset = widget.blockSize / 2;

    return Positioned(
      bottom: (block.layer + block.row) * offset,
      left: (block.col + block.layer * 0.5) * offset,
      child: GestureDetector(
        onTap: () {
          _inspectBlock(block);
        },
        child: Container(
          width: widget.blockSize,
          height: widget.blockSize,
          decoration: BoxDecoration(
            color: block.color,
            border: Border.all(color: Colors.black, width: 0.5),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(1, 2)),
            ],
          ),
          alignment: Alignment.center,
          child: Text('${block.layer}-${block.row}-${block.col}', style: const TextStyle(fontSize: 10)),
        ),
      ),
    );
  }

  void _inspectBlock(PyramidBlock block) {
    // Inspect or perform actions with the tapped block
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Block Info"),
        content: Text('Layer: ${block.layer}\nRow: ${block.row}\nColumn: ${block.col}'),
      ),
    );
  }
}