import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MarioPage extends StatefulWidget {
  const MarioPage({super.key});

  static PageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const MarioPage(),
    );
  }

  @override
  State<MarioPage> createState() => _MarioPageState();
}

class _MarioPageState extends State<MarioPage> {
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
        title: const Text('Mario'),
      ),
      body: GameWidget(game: game),
    );
  }
}

class Mario extends Game {
  late final FragmentProgram _program;
  late final FragmentShader shader;

  double time = 0;

  void dispose() {
    shader.dispose();
  }

  @override
  Future<void>? onLoad() async {
    _program = await FragmentProgram.fromAsset('shaders/mario.glsl');
    shader = _program.fragmentShader();
  }

  @override
  void render(ui.Canvas canvas) {
    shader
      ..setFloat(0, size.x)
      ..setFloat(1, size.y)
      ..setFloat(2, time);

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
