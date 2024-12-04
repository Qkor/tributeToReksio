import 'package:flutter/material.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart' as unistroke;
import 'package:ttr/spell_painter.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  final List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
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
          if (recognized == null) {
            print('No match found');
          } else {
            print('Stroke recognized as ${recognized.name} with score ${recognized.score}');
          }
          setState(() {
            _points.clear(); // Clear canvas after a spell attempt.
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: SpellPainter(_points),
        ),
      ),
    );
  }
}