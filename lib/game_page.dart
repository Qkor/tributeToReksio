import 'package:flutter/material.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart' as unistroke;
import 'package:ttr/assets_manager.dart';
import 'package:ttr/enemy.dart';
import 'package:ttr/spell_manager.dart';
import 'package:ttr/spell_painter.dart';
import 'package:ttr/spells.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  final List<Offset> _points = [];
  bool ready = false;

  _loadAssets() async {
    await AssetsManager.loadAssets();
    setState(() {
      ready = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  @override
  Widget build(BuildContext context) {
    Spell? spell;

    if(!ready){
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset localPosition = renderBox.globalToLocal(details.globalPosition);
            _points.add(localPosition);
          });
        },
        onPanEnd: (_) {
          final recognized = unistroke.recognizeCustomUnistroke(_points);
          if (recognized != null && recognized.score>0.85) {
            print('Stroke recognized as ${recognized.name} with score ${recognized.score}');
            SpellManager.spell = recognized.name;
          } else{
            spell = null;
          }
          setState(() {
            _points.clear();
            print(spell);
          });
        },
        child: Stack(
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: SpellPainter(_points),
            ),
            Enemy(),
          ],
        ),
      ),
    );
  }
}