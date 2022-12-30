import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  static PageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const WaterPage(),
    );
  }

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  final game = Water();

  @override
  void dispose() {
    game.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water'),
      ),
      body: GameWidget(game: game),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: Object(),
            onPressed: () => game.seaHeight += 0.1,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: Object(),
            onPressed: () => game.seaHeight -= 0.1,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class Water extends Game {
  late final devicePixelRatio = MediaQuery.of(buildContext!).devicePixelRatio;

  late final FragmentProgram _program;
  late final FragmentShader shader;

  double time = 0;

  double seaHeight = 0.2;

  void dispose() {
    shader.dispose();
  }

  @override
  Future<void>? onLoad() async {
    _program = await FragmentProgram.fromAsset('shaders/water.glsl');
    shader = _program.fragmentShader();
  }

  @override
  void render(ui.Canvas canvas) {
    shader
      ..setFloat(0, size.x)
      ..setFloat(1, size.y)
      ..setFloat(2, time)
      ..setFloat(3, seaHeight.clamp(0, 1));

    canvas
      ..translate(size.x, size.y)
      ..rotate(180 * degrees2Radians)
      ..drawRect(
        Offset.zero & size.toSize(),
        Paint()..shader = shader,
      );
  }

  @override
  void update(double dt) {
    time += dt;
  }
}
