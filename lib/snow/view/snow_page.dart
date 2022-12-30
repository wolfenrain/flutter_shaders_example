import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class SnowPage extends StatefulWidget {
  const SnowPage({super.key});

  static PageRoute<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SnowPage(),
    );
  }

  @override
  State<SnowPage> createState() => _SnowPageState();
}

class _SnowPageState extends State<SnowPage> {
  int count = 0;

  double time = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        time += 0.016;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: 'shaders/snow.glsl',
      (context, shader, child) {
        return AnimatedSampler(
          (image, size, offset, canvas) {
            final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
            shader
              ..setFloat(0, image.width.toDouble() / devicePixelRatio)
              ..setFloat(1, image.height.toDouble() / devicePixelRatio)
              ..setFloat(2, time)
              ..setImageSampler(0, image);

            canvas
              ..save()
              ..translate(offset.dx, offset.dy)
              ..drawRect(
                Offset.zero & size,
                Paint()..shader = shader,
              )
              ..restore();
          },
          child: child!,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Snow'),
        ),
        body: Center(
          child: Text(
            '$count',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: Object(),
              onPressed: () => setState(() {
                count++;
              }),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: Object(),
              onPressed: () => setState(() {
                count--;
              }),
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
