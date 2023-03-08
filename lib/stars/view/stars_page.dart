import 'dart:async';
import 'dart:ui' as ui;

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class StarsPage extends StatefulWidget {
  const StarsPage({super.key});

  static PageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const StarsPage(),
    );
  }

  @override
  State<StarsPage> createState() => _StarsPageState();
}

class _StarsPageState extends State<StarsPage> {
  final game = Mario();

  @override
  void dispose() {
    game.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stars'),
      ),
      body: GameWidget(game: game),
    );
  }
}

class Mario extends Game with MouseMovementDetector {
  late final ui.FragmentProgram _program;
  late final ui.FragmentShader shader;

  double time = 0;

  void dispose() {
    time = 0;
    shader.dispose();
  }

  Vector2 mousePosition = Vector2.zero();

  @override
  void onMouseMove(PointerHoverInfo info) {
    mousePosition.setFrom(info.eventPosition.widget);
    super.onMouseMove(info);
  }

  @override
  Future<void>? onLoad() async {
    _program = await ui.FragmentProgram.fromAsset('shaders/stars.glsl');
    shader = _program.fragmentShader();
  }

  @override
  void render(ui.Canvas canvas) {
    shader
      ..setFloat(0, size.x)
      ..setFloat(1, size.y)
      ..setFloat(2, time)
      ..setFloat(3, mousePosition.x)
      ..setFloat(3, mousePosition.y);

    canvas
      ..translate(size.x, size.y)
      ..rotate(180 * degrees2Radians)
      ..translate(size.x, 0)
      ..scale(-1, 1)
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
