import 'dart:async';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class JamPage extends StatefulWidget {
  const JamPage({super.key});

  static PageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const JamPage(),
    );
  }

  @override
  State<JamPage> createState() => _JamPageState();
}

class _JamPageState extends State<JamPage> {
  final game = Jam();

  @override
  void dispose() {
    game.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jam'),
      ),
      body: GameWidget(game: game),
    );
  }
}

class Jam extends Game {
  late final devicePixelRatio = MediaQuery.of(buildContext!).devicePixelRatio;

  late final FragmentProgram _program;
  late final FragmentShader shader;

  double time = 0;

  void dispose() {
    shader.dispose();
  }

  @override
  Future<void>? onLoad() async {
    _program = await FragmentProgram.fromAsset('shaders/jam.glsl');
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
