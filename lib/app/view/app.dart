import 'package:flutter/material.dart';
import 'package:flutter_shaders_example/glitch/glitch.dart';
import 'package:flutter_shaders_example/jam/jam.dart';
import 'package:flutter_shaders_example/mario/mario.dart';
import 'package:flutter_shaders_example/snow/snow.dart';
import 'package:flutter_shaders_example/water/water.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
      //   colorScheme: ColorScheme.fromSwatch(
      //     accentColor: const Color(0xFF13B9FF),
      //   ),
      // ),
      theme: ThemeData.dark(),
      home: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shaders'),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        padding: const EdgeInsets.all(32),
        crossAxisSpacing: 32,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(WaterPage.route()),
            child: const Text('Water'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(JamPage.route()),
            child: const Text('Jam'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(MarioPage.route()),
            child: const Text('Mario'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(GlitchPage.route()),
            child: const Text('Glitch'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(SnowPage.route()),
            child: const Text('Snow'),
          ),
        ],
      ),
    );
  }
}
